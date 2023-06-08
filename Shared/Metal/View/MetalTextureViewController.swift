//
//  MetalTextureViewController.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/31.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import MetalKit

class MetalTextureViewController: CPViewController {
    
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
//        self.renderer = MetalTrangleRenderer(mtkView: mtkView)
//        mtkView.delegate = self.renderer
        
        self.view = mtkView
    }
    
}

struct MetalTextureViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(MetalTextureViewController())
    }
}
