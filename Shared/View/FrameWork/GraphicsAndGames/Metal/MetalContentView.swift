//
//  MetalContentView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/20.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import MetalKit

struct MetalContentView: CPViewRepresent {
    func makeView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.enableSetNeedsDisplay = true
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.clearColor = MTLClearColor(red: 1, green: 0, blue: 0, alpha: 1)
        mtkView.delegate = context.coordinator
        return mtkView
    }
    
    func updateView(view: MTKView, context: Context) {
        
    }
    
    func makeCoordinator() -> Cooordinator {
        Cooordinator()
    }
    
    class Cooordinator: NSObject, MTKViewDelegate {
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
            
        }
        
        func draw(in view: MTKView) {
            guard let renderPassDescriptor = view.currentRenderPassDescriptor else {
                return
            }
            guard let commandQueue = view.device?.makeCommandQueue() else {
                return
            }
            guard let commandBuffer = commandQueue.makeCommandBuffer() else {
                return
            }
            guard let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
                return
            }
            commandEncoder.endEncoding()
            
            guard let drawable = view.currentDrawable else {
                return
            }
            
            commandBuffer.present(drawable)
            
            commandBuffer.commit()
        }
    }
}

struct MetalContentView_Previews: PreviewProvider {
    static var previews: some View {
        MetalContentView()
    }
}
