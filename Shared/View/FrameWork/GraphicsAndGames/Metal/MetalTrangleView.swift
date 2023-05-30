//
//  MetalTrangleView.swift
//  SwiftHelper
//
//  Created by Sauron on 2023/5/29.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import MetalKit

struct MetalTrangleView: CPViewRepresent {
    
    func makeView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.enableSetNeedsDisplay = true
        mtkView.device = MTLCreateSystemDefaultDevice()
//        mtkView.clearColor = MTLClearColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        context.coordinator.renderer = MetalRenderer(mtkView: mtkView)
        mtkView.delegate = context.coordinator.renderer
        return mtkView
    }
    
    func updateView(view: MTKView, context: Context) {
        
    }
    
    func makeCoordinator() -> Cooordinator {
        Cooordinator()
    }

    class Cooordinator {
        var renderer: MetalRenderer?
    }
}

struct MetalTrangleView_Previews: PreviewProvider {
    static var previews: some View {
        MetalTrangleView()
    }
}
