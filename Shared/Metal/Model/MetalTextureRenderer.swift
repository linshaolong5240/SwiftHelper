//
//  MetalTextureRenderer.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/31.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Foundation
import MetalKit

public class MetalTextureRenderer: NSObject, MTKViewDelegate {
    private var device: MTLDevice
    private var drawableSize: vector_uint2
    private var pipelineState: MTLRenderPipelineState
    private var commandQueue: MTLCommandQueue
    
    public init?(mtkView: MTKView) {
        guard let device = mtkView.device else {
            return nil
        }
        
        self.device = device
        self.drawableSize = vector_uint2(x: 0, y: 0)
        
        let metalLibrary = device.makeDefaultLibrary()
        let vertexFunction = metalLibrary?.makeFunction(name: "vertexShader")
        let fragmentFunction = metalLibrary?.makeFunction(name: "fragmentShader")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.label = "Simple Pipeline"
        pipelineStateDescriptor.vertexFunction = vertexFunction
        pipelineStateDescriptor.fragmentFunction = fragmentFunction
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat
        do {
            self.pipelineState = try device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        } catch let error {
            fatalError(error.localizedDescription)
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
        drawableSize.x = UInt32(size.width)
        drawableSize.y = UInt32(size.height)
    }
    
    public func draw(in view: MTKView) {
#if DEBUG
        print("\(Self.self) \(#function)" )
#endif
        let triangleVertices: [SPVertex] = [
            SPVertex(position: vector_float2(250, -250), color: vector_float4(1, 0, 0, 1)),
            SPVertex(position: vector_float2(-250, -250), color: vector_float4(0, 1, 0, 1)),
            SPVertex(position: vector_float2(0, sqrtf(250 * 250 * 2)), color: vector_float4(0, 0, 1, 1)),
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
        
        // 编码视窗命令
        commandEncoder.setViewport(MTLViewport(originX: 0, originY: 0, width: Double(drawableSize.x), height: Double(drawableSize.y), znear: 0, zfar: 1))
        // 编码渲染管线状态命令
        commandEncoder.setRenderPipelineState(pipelineState)
        
        // 编码传递顶点函数参数1命令
        commandEncoder.setVertexBytes(triangleVertices, length: MemoryLayout<SPVertex>.size * triangleVertices.count, index: 0)
        // 编码传递顶点函数参数2命令
        commandEncoder.setVertexBytes(&drawableSize, length: MemoryLayout<vector_uint2>.size, index: 1)
        // 编码绘图命令
        commandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: triangleVertices.count)
        // 结束编码命令
        commandEncoder.endEncoding()
        
        guard let drawable = view.currentDrawable else {
            return
        }
        
        commandBuffer.present(drawable)
        
        commandBuffer.commit()
    }
}
