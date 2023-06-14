//
//  MetalTextureComputeRenderer.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/14.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import MetalKit

class MetalTextureComputeRenderer: NSObject, MTKViewDelegate {
    private var device: MTLDevice
    private var drawableSize: CGSize
    private var viewPortSize: vector_uint2
    private var computePipelineState: MTLComputePipelineState
    private var threadgroupSize: MTLSize
    private var threadgroupCount: MTLSize
    private var renderPipelineState: MTLRenderPipelineState
    private var inputTexture: MTLTexture
    private var outputTexture: MTLTexture
    private var commandQueue: MTLCommandQueue
    
    public init?(mtkView: MTKView) {
        guard let device = mtkView.device else {
            return nil
        }
        
        self.device = device
        self.drawableSize = .zero
        self.viewPortSize = vector_uint2(x: 0, y: 0)
        
        let metalLibrary = device.makeDefaultLibrary()
        guard let computeFunction = metalLibrary?.makeFunction(name: "TextureGreyscale") else {
#if DEBUG
            print("Failed to find the function.")
#endif
            return nil
        }
        
        do {
            self.computePipelineState = try device.makeComputePipelineState(function: computeFunction)
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
        guard let vertexFunction = metalLibrary?.makeFunction(name: "TextureVertexShader") else {
#if DEBUG
            print("Failed to find the function.")
#endif
            return nil
        }
        guard let fragmentFunction = metalLibrary?.makeFunction(name: "TextureSamplingShader") else {
#if DEBUG
            print("Failed to find the function.")
#endif
            return nil
        }
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.label = "Texture Compute Pipeline"
        pipelineStateDescriptor.vertexFunction = vertexFunction
        pipelineStateDescriptor.fragmentFunction = fragmentFunction
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat
        do {
            self.renderPipelineState = try device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
        guard let imageURL = Bundle.main.url(forResource: "MetalTextureCompute", withExtension: "tga") else {
            return nil
        }
        guard let tgaImage = SPTGAImage(contentsOfFile: imageURL) else {
            return nil
        }
        
        let textureDescriptor = MTLTextureDescriptor()
        textureDescriptor.textureType = .type2D
        textureDescriptor.pixelFormat = .bgra8Unorm
        textureDescriptor.width = tgaImage.width
        textureDescriptor.height = tgaImage.height
        textureDescriptor.usage = .shaderRead
        guard let inputTexture = device.makeTexture(descriptor: textureDescriptor) else {
            return nil
        }
        self.inputTexture = inputTexture
        
        textureDescriptor.usage = [.shaderRead, .shaderWrite]
        guard let outputTexture = device.makeTexture(descriptor: textureDescriptor) else {
            return nil
        }
        self.outputTexture = outputTexture
        
        let region = MTLRegion(origin: MTLOrigin(x: 0, y: 0, z: 0), size: MTLSize(width: tgaImage.width, height: tgaImage.height, depth: 1))
        tgaImage.data.withUnsafeBytes { rawBufferPointer in
            guard let p = rawBufferPointer.baseAddress else {
                return
            }
            inputTexture.replace(region: region, mipmapLevel: 0, withBytes: p, bytesPerRow: tgaImage.bytesPerRow)
        }
        // Set the compute kernel's threadgroup size to 16 x 16.
        self.threadgroupSize = MTLSize(width: 16, height: 16, depth: 1)
        let threadgoupCountWidth = (inputTexture.width + threadgroupSize.width - 1) / threadgroupSize.width
        let threadgoupCountHeight = (inputTexture.height + threadgroupSize.height - 1) / threadgroupSize.height
        self.threadgroupCount = MTLSize(width: threadgoupCountWidth, height: threadgoupCountHeight, depth: 1)
        
        guard let commandQueue = device.makeCommandQueue() else {
            return nil
        }
        self.commandQueue = commandQueue
        super.init()
    }
    
    deinit {
#if DEBUG
        print("\(Self.self) deinit" )
#endif
    }
    
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
#if DEBUG
        print("\(Self.self) \(#function)" )
#endif
        viewPortSize.x = UInt32(size.width)
        viewPortSize.y = UInt32(size.height)
        drawableSize = size
    }
    
    public func draw(in view: MTKView) {
#if DEBUG
        print("\(Self.self) \(#function)" )
#endif
        
        let quadRangleVertices: [SPTextureVertex] = [
            SPTextureVertex(position: vector_float4(-250, 250, 0, 1.0), textureCoordinate: vector_float2(0, 1.0)),
            SPTextureVertex(position: vector_float4(250, 250, 0, 1.0), textureCoordinate: vector_float2(1.0, 1.0)),
            SPTextureVertex(position: vector_float4(-250, -250, 0, 1.0), textureCoordinate: vector_float2(0, 0)),
            
            SPTextureVertex(position: vector_float4(250, 250, 0, 1.0), textureCoordinate: vector_float2(1.0, 1.0)),
            SPTextureVertex(position: vector_float4(-250, -250, 0, 1.0), textureCoordinate: vector_float2(0, 0)),
            SPTextureVertex(position: vector_float4(250, -250, 0, 1.0), textureCoordinate: vector_float2(1.0, 0.0)),
        ]
        
        guard let commandBuffer = commandQueue.makeCommandBuffer() else {
            return
        }
        commandBuffer.label = "\(Self.self) \(#function) commandBuffer"
        
        guard let computeEncoder = commandBuffer.makeComputeCommandEncoder() else {
            return
        }
        
        computeEncoder.setComputePipelineState(self.computePipelineState)
        computeEncoder.setTexture(inputTexture, index: Int(SPTextureIndexInput.rawValue))
        computeEncoder.setTexture(outputTexture, index: Int(SPTextureIndexOutput.rawValue))
        computeEncoder.dispatchThreadgroups(threadgroupCount, threadsPerThreadgroup: threadgroupSize)
        computeEncoder.endEncoding()
        
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else {
            return
        }
        // 开始发送命令
        guard let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
            return
        }
        commandEncoder.label = "\(Self.self) \(#function) commandEncoder"
        
        // 编码渲染管线状态命令
        commandEncoder.setRenderPipelineState(renderPipelineState)
        
        // 编码视窗命令
        commandEncoder.setViewport(MTLViewport(originX: 0, originY: 0, width: Double(drawableSize.width), height: Double(drawableSize.height), znear: 0, zfar: 1))
        
        // 顶点函数参数
        commandEncoder.setVertexBytes(quadRangleVertices, length: MemoryLayout<SPTextureVertex>.size * quadRangleVertices.count, index: Int(SPVertexInputIndexVertices.rawValue))
        commandEncoder.setVertexBytes(&viewPortSize, length: MemoryLayout<vector_uint2>.size, index: Int(SPVertexInputIndexViewport.rawValue))
        // 片段着色器函数参数
        commandEncoder.setFragmentTexture(outputTexture, index: Int(SPTextureIndexOutput.rawValue))
        // 编码绘图命令
        commandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: quadRangleVertices.count)
        // 结束编码命令
        commandEncoder.endEncoding()
        
        guard let drawable = view.currentDrawable else {
            return
        }
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
