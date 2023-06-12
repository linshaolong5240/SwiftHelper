//
//  MetalDepthRenderer.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/9.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Foundation
import MetalKit

class MetalDepthRenderer: NSObject, MTKViewDelegate {
    private var device: MTLDevice
    private var drawableSize: vector_uint2
    private var pipelineState: MTLRenderPipelineState
    private var commandQueue: MTLCommandQueue
    private var depthStencilState: MTLDepthStencilState
    
    public var topDepth: Float = 0
    public var lefDepth: Float = 0
    public var rightDepth: Float = 0
    
    public init?(mtkView: MTKView) {
        mtkView.clearColor = MTLClearColor(red: 1, green: 0, blue: 0, alpha: 1)
        mtkView.depthStencilPixelFormat = .depth32Float;
        mtkView.clearDepth = 1.0

        guard let device = mtkView.device else {
            return nil
        }
        
        self.device = device
        self.drawableSize = vector_uint2(x: 0, y: 0)
        
        let metalLibrary = device.makeDefaultLibrary()
        let vertexFunction = metalLibrary?.makeFunction(name: "vertexShader")
        let fragmentFunction = metalLibrary?.makeFunction(name: "fragmentShader")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.label = "Depth Pipeline"
        pipelineStateDescriptor.depthAttachmentPixelFormat = mtkView.depthStencilPixelFormat
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat
        pipelineStateDescriptor.vertexFunction = vertexFunction
        pipelineStateDescriptor.fragmentFunction = fragmentFunction
        do {
            self.pipelineState = try device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        } catch let error {
            fatalError(error.localizedDescription)
        }
        guard let commandQueue = device.makeCommandQueue() else {
            return nil
        }
        self.commandQueue = commandQueue
        
        let depthDescriptor = MTLDepthStencilDescriptor();
        depthDescriptor.depthCompareFunction = .lessEqual;
        depthDescriptor.isDepthWriteEnabled = true
        guard let depthStencilState = device.makeDepthStencilState(descriptor: depthDescriptor) else {
            return nil
        }
        self.depthStencilState = depthStencilState;

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
        drawableSize.x = UInt32(size.width)
        drawableSize.y = UInt32(size.height)
    }
    
    public func draw(in view: MTKView) {
#if DEBUG
        print("\(Self.self) \(#function)" )
        print("\(topDepth) \(lefDepth) \(rightDepth)" )

#endif
        let width = Float(drawableSize.x * UInt32(ScreenHelper.mainScale))
        let height = Float(drawableSize.y * UInt32(ScreenHelper.mainScale))

        let quadRangleVertices: [SPVertex] = [
            SPVertex(position: vector_float4(0, height, 1.5, 1), color: vector_float4(0.5, 0.5, 0.5, 1)),
            SPVertex(position: vector_float4(width, height, 1.5, 1), color: vector_float4(0.5, 0.5, 0.5, 1)),
            SPVertex(position: vector_float4(0, 0, 0.5, 1), color: vector_float4(0.5, 0.5, 0.5, 1)),
            SPVertex(position: vector_float4(width, 0, 0.5, 1), color: vector_float4(0.5, 0.5, 0.5, 1)),
        ]
        
        let triangleVertices: [SPVertex] = [
            SPVertex(position: vector_float4(width / 2, height - 100, topDepth, 0), color: vector_float4(1, 0, 0, 1)),
            SPVertex(position: vector_float4(100, 100, lefDepth, 0), color: vector_float4(0, 1, 0, 1)),
            SPVertex(position: vector_float4(width - 100, 100, rightDepth, 0), color: vector_float4(0, 0, 1, 1)),
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
        
        commandEncoder.setRenderPipelineState(pipelineState)
        commandEncoder.setDepthStencilState(depthStencilState)

        commandEncoder.setViewport(MTLViewport(originX: 0, originY: 0, width: Double(drawableSize.x), height: Double(drawableSize.y), znear: 0, zfar: 1))
        
        commandEncoder.setVertexBytes(&drawableSize, length: MemoryLayout<vector_uint2>.size, index: Int(SPVertexInputIndexViewport.rawValue))
        
        commandEncoder.setVertexBytes(quadRangleVertices, length: MemoryLayout<SPVertex>.size * quadRangleVertices.count, index: Int(SPVertexInputIndexVertices.rawValue))
        commandEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: quadRangleVertices.count)

        commandEncoder.setVertexBytes(triangleVertices, length: MemoryLayout<SPVertex>.size * triangleVertices.count, index: Int(SPVertexInputIndexVertices.rawValue))
        commandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: triangleVertices.count)
        commandEncoder.endEncoding()
        
        guard let drawable = view.currentDrawable else {
            return
        }
        
        commandBuffer.present(drawable)
        
        commandBuffer.commit()
    }
}
