//
//  MetalCompute.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/9.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Foundation
import Metal

public class MetalCompute {
    public var device: MTLDevice
    public var commandQueue: MTLCommandQueue
    public var pipelineState: MTLComputePipelineState
    public var buffer0: MTLBuffer?
    public var buffer1: MTLBuffer?
    public var buffer2: MTLBuffer?
    private var arrayLength: Int = 1000//* 1 << 24
    private var bufferLength: Int = MemoryLayout<Float>.size * 1000//* 1 << 24
    
    init?(device: MTLDevice) {
        guard let library = device.makeDefaultLibrary() else {
#if DEBUG
            print("Failed to find the default library.")
#endif
            return nil
        }
        
        guard let function = library.makeFunction(name: "add_arrays") else {
#if DEBUG
            print("Failed to find the function.")
#endif
            return nil
        }
        
        do {
            self.pipelineState = try device.makeComputePipelineState(function: function)
        } catch let error {
#if DEBUG
            print("Failed to created pipeline state object: \(error)")
#endif
            return nil
        }
        
        guard let commandQueue = device.makeCommandQueue() else {
#if DEBUG
            print("Failed to find the command queue.")
#endif
            return  nil
        }
        self.device = device
        self.commandQueue = commandQueue
    }
    
    public func prepareData() {
        func generateData(buffer: MTLBuffer, length: Int) {
            let pointer = buffer.contents().initializeMemory(as: Float.self, to: 0)
            
            for i in 0..<length {
                pointer[i] = Float(i)
            }
        }
        
        buffer0 = device.makeBuffer(length: bufferLength, options: [.storageModeShared])
        buffer1 = device.makeBuffer(length: bufferLength, options: [.storageModeShared])
        buffer2 = device.makeBuffer(length: bufferLength, options: [.storageModeShared])
        if let buffer = buffer0 {
            generateData(buffer: buffer, length: arrayLength)
        }
        if let buffer = buffer1 {
            generateData(buffer: buffer, length: arrayLength)
        }
    }
    
    public func sendCommand() {
        guard let commandBuffer = commandQueue.makeCommandBuffer() else {
            return
        }
        
        guard let encoder = commandBuffer.makeComputeCommandEncoder() else {
            return
        }
        
        encoderAddCommand(encoder: encoder)
        encoder.endEncoding()
        commandBuffer.commit()
        // Normally, you want to do other work in your app while the GPU is running,
        // but in this example, the code simply blocks until the calculation is complete.
        commandBuffer.waitUntilCompleted()
    }
    
    public func verifyResult() {
        guard let a = buffer0?.contents().bindMemory(to: Float.self, capacity: bufferLength) else {
            return
        }
        guard let b = buffer1?.contents().bindMemory(to: Float.self, capacity: bufferLength) else {
            return
        }
        guard let c = buffer2?.contents().bindMemory(to: Float.self, capacity: bufferLength) else {
            return
        }
        for i in 0..<arrayLength {
            if c[i] != a[i] + b[i] {
#if DEBUG
                print("Compute ERROR: index=\(i) result=\(c[i]) vs \(a[i] + b[i])=a+b\n")
#endif
                return
            }
        }
#if DEBUG
        print("Compute results as expected\n")
#endif
    }
    
    private func encoderAddCommand(encoder: MTLComputeCommandEncoder) {
        encoder.setComputePipelineState(pipelineState)
        encoder.setBuffer(buffer0, offset: 0, index: 0)
        encoder.setBuffer(buffer1, offset: 0, index: 1)
        encoder.setBuffer(buffer2, offset: 0, index: 2)
        let gridSize = MTLSize(width: arrayLength, height: 1, depth: 1)
        let maxthreadGroupSize = min(pipelineState.maxTotalThreadsPerThreadgroup, arrayLength)
        
        let groupSize = MTLSize(width: maxthreadGroupSize, height: 1, depth: 1)
        
        encoder.dispatchThreads(gridSize, threadsPerThreadgroup: groupSize)
    }
    
}
