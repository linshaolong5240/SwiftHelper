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
        #if canImport(AppKit)
        let button = NSButton(title: "Compute on GPU", target: self, action: #selector(compute))
        #endif
        #if canImport(UIKit)
        let button = UIButton()
        button.titleLabel?.text = "Compute on GPU"
        button.addTarget(self, action: #selector(compute), for: .touchUpInside)
#endif
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

#if canImport(AppKit)
    override func viewDidAppear() {
        super.viewDidAppear()
        if !isMetalInit {
            initMetal()
        }
    }
#endif
    
#if canImport(UIKit)
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if !isMetalInit {
        initMetal()
    }
}
#endif

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

