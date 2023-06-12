//
//  MetalFrameworkView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/20.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct MetalFrameworkView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Compute") {
                    PlatformViewControllerRepresent(MetalComputeViewController())
                }
                NavigationLink("Metal Content") {
//                    MetalContentView()
                    PlatformViewControllerRepresent(MetalContentViewController())
                }
                NavigationLink("Trangle") {
//                    MetalTrangleView()
                    PlatformViewControllerRepresent(MetalTriangleViewController())
                        .overlay {
                            GeometryReader { geometry in
                                Text("width:\(geometry.size.width), height:\(geometry.size.height)")
                            }
                        }
                }
                NavigationLink("Trangle depth testing") {
                    MetalDepthView()
                }
                NavigationLink("Texture") {
                    MetalTextureView()
                }
            }
        }
    }
}

struct MetalFrameworkView_Previews: PreviewProvider {
    static var previews: some View {
        MetalFrameworkView()
    }
}

