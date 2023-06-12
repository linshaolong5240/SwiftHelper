//
//  MetalTextureRenderer.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/31.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Foundation
import MetalKit
import SPImage

public class MetalTextureRenderer: NSObject, MTKViewDelegate {
    private var device: MTLDevice
    private var drawableSize: CGSize
    private var viewPortSize: vector_uint2
    private var pipelineState: MTLRenderPipelineState
    private var texture: MTLTexture
    private var commandQueue: MTLCommandQueue
    
    public init?(mtkView: MTKView) {
        guard let device = mtkView.device else {
            return nil
        }
        
        self.device = device
        self.drawableSize = .zero
        self.viewPortSize = vector_uint2(x: 0, y: 0)
        
        let metalLibrary = device.makeDefaultLibrary()
        guard let vertexFunction = metalLibrary?.makeFunction(name: "TextureVertexShader") else {
            return nil
        }
        guard let fragmentFunction = metalLibrary?.makeFunction(name: "TextureSamplingShader") else {
            return nil
        }
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.label = "Texture Pipeline"
        pipelineStateDescriptor.vertexFunction = vertexFunction
        pipelineStateDescriptor.fragmentFunction = fragmentFunction
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat
        do {
            self.pipelineState = try device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
        guard let imageURL = Bundle.main.url(forResource: "MetalTextureCompute", withExtension: "tga") else {
            return nil
        }
        guard let tgaImage = SPTGAImage(contentsOfFile: imageURL) else {
            return nil
        }
        
//        guard let image = CrossImage(named: "MetalTexture") else {
//            return nil
//        }
//
//        guard let cgImage = image.cgImage else {
//            return nil
//        }
//
//        guard let imageData = cgImage.makeData(to: .png) else {
//            return nil
//        }
        
        let textureDescriptor = MTLTextureDescriptor()
        textureDescriptor.textureType = .type2D
        textureDescriptor.pixelFormat = .bgra8Unorm
        textureDescriptor.width = tgaImage.width
        textureDescriptor.height = tgaImage.height
        
        guard let texture = device.makeTexture(descriptor: textureDescriptor) else {
            return nil
        }
        self.texture = texture
        
        let region = MTLRegion(origin: MTLOrigin(x: 0, y: 0, z: 0), size: MTLSize(width: tgaImage.width, height: tgaImage.height, depth: 1))
        tgaImage.data.withUnsafeBytes { rawBufferPointer in
            guard let p = rawBufferPointer.baseAddress else {
                return
            }
            texture.replace(region: region, mipmapLevel: 0, withBytes: p, bytesPerRow: tgaImage.bytesPerRow)
        }

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
                
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else {
            return
        }
        
        guard let commandBuffer = commandQueue.makeCommandBuffer() else {
            return
        }
        commandBuffer.label = "\(Self.self) \(#function) commandBuffer"
        
        // 开始发送命令
        guard let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
            return
        }
        commandEncoder.label = "\(Self.self) \(#function) commandEncoder"
        
        // 编码渲染管线状态命令
        commandEncoder.setRenderPipelineState(pipelineState)

        // 编码视窗命令
        commandEncoder.setViewport(MTLViewport(originX: 0, originY: 0, width: Double(drawableSize.width), height: Double(drawableSize.height), znear: 0, zfar: 1))
        
        // 顶点函数参数
        commandEncoder.setVertexBytes(quadRangleVertices, length: MemoryLayout<SPTextureVertex>.size * quadRangleVertices.count, index: 0)
        commandEncoder.setVertexBytes(&viewPortSize, length: MemoryLayout<vector_uint2>.size, index: 1)
        // 片段着色器函数参数
        commandEncoder.setFragmentTexture(texture, index: 0)
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
