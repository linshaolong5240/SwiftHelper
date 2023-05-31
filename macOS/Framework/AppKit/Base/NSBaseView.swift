//
//  NSBaseView.swift
//  SwiftHelper (macOS)
//
//  Created by sauron on 2023/5/31.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Cocoa

extension NSView {
    var backgroundColor: NSColor? {
        get {
            guard let cgColor = self.layer?.backgroundColor else {
                return nil
            }
            return NSColor(cgColor: cgColor)
        }
        set { self.layer?.backgroundColor = newValue?.cgColor }
    }
}

class NSBaseView: NSView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        // 使用 CALayer 管理渲染视图
        self.wantsLayer = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
