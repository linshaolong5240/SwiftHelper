//
//  MetalTextureComputeView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/13.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import MetalKit

struct MetalTextureComputeView: CPViewRepresent {
    
    func makeView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.enableSetNeedsDisplay = true
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.clearColor = MTLClearColor(red: 1, green: 0, blue: 0, alpha: 1)
        context.coordinator.renderer = MetalTextureComputeRenderer(mtkView: mtkView)
        mtkView.delegate = context.coordinator.renderer
        
        return mtkView
    }
    
    func updateView(view: MTKView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator {
        var renderer: MetalTextureComputeRenderer?
    }
}

struct MetalTextureComputeView_Previews: PreviewProvider {
    static var previews: some View {
        MetalTextureComputeView()
    }
}
