//
//  ImageIOFrameworkView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/14.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct ImageIOFrameworkView: View {
    #if canImport(AppKit)
    private let cgImage: CGImage? = NSImage(systemSymbolName: "swift", accessibilityDescription: "accessibilityDescription")?.cgImage
    #endif
    #if canImport(UIKit)
    private let cgImage: CGImage? = UIImage(systemName: "swift")?.cgImage
    #endif
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("CGImage")
            if let item = cgImage {
                Image(item, scale: 1.0, label: Text("Image"))
                    .renderingMode(.template)
                    .foregroundColor(Color.accentColor)
            }
            Text("Save CGImage")
        }
    }
}

struct ImageIOFrameworkView_Previews: PreviewProvider {
    static var previews: some View {
        ImageIOFrameworkView()
    }
}
