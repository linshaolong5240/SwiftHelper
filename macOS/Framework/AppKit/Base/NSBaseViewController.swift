//
//  NSBaseViewController.swift
//  SwiftHelper (macOS)
//
//  Created by sauron on 2023/5/31.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Cocoa

public class NSBaseViewController: NSViewController {
    
    /// 不使用xib文件需要手动创建view
    public override func loadView() {
        self.view = NSBaseView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
