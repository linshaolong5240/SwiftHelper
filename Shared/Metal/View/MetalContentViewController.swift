//
//  MetalContentViewController.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/31.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import MetalKit

class MetalContentViewController: CPViewController {
    
#if canImport(AppKit)
    override func loadView() {
        self.view = NSBaseView()
    }
#endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let mtkView = MTKView()
        mtkView.enableSetNeedsDisplay = true
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.clearColor = MTLClearColor(red: 1, green: 0, blue: 0, alpha: 1)
        mtkView.delegate = self
        self.view = mtkView
    }
    
}

struct MetalContentViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(MetalContentViewController())
    }
}

extension MetalContentViewController: MTKViewDelegate {
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
