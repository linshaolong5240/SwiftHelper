//
//  CoreImageFrameworkView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/4/28.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct CoreImageFrameworkView: View {
    #if canImport(AppKit)
    private let ciImage = CIImage(cgImage: NSImage(systemSymbolName: "photo", accessibilityDescription: nil)!.cgImage!).transformed(by: CGAffineTransform(scaleX: 1.0, y: 1.0))
    private let ciImage2 = CIImage(cgImage: NSImage(systemSymbolName: "photo", accessibilityDescription: nil)!.cgImage!).transformed(by: CGAffineTransform(scaleX: 2.0, y: 2.0))
    #endif
    #if canImport(UIKit)
    private let ciImage = CIImage(cgImage: UIImage(systemName: "photo")!.cgImage!).transformed(by: CGAffineTransform(scaleX: 1.0, y: 1.0))
    private let ciImage2 = CIImage(cgImage: UIImage(systemName: "photo")!.cgImage!).transformed(by: CGAffineTransform(scaleX: 2.0, y: 2.0))
    #endif
    
    var body: some View {
        List {
            Image(systemName: "photo")
            Image.init(CIContext().createCGImage(ciImage, from: ciImage.extent)!, scale: 1.0, label: Text("Image1"))
            Image.init(CIContext().createCGImage(ciImage2, from: ciImage2.extent)!, scale: 1.0, label: Text("Image2"))
        }
    }
}

struct CoreImageFrameworkView_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageFrameworkView()
    }
}
