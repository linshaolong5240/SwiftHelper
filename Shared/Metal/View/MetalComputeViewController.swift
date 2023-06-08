//
//  MetalComputeViewController.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/31.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import MetalKit
import SnapKit

class MetalComputeViewController: CPViewController {
    private var metalCompute: MetalCompute?
    private var isMetalInit: Bool = false
    
#if canImport(AppKit)
    override func loadView() {
        self.view = NSBaseView()
    }
#endif

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let button = CPButton(title: "Compute on GPU", target: self, action: #selector(compute))
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if !isMetalInit {
            initMetal()
        }
    }
    
    private func initMetal() {
        defer { self.isMetalInit = true }
        guard let device = MTLCreateSystemDefaultDevice() else {
            return
        }
        self.metalCompute = MetalCompute(device: device)
        self.metalCompute?.prepareData()
    }
    
    @objc func compute() {
        #if DEBUG
        print("\(Self.self) \(#function)")
        #endif
        self.metalCompute?.sendCommand()
        self.metalCompute?.verifyResult()
    }
}

struct MetalAdderViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(MetalContentViewController())
    }
}

