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
                NavigationLink("Metal Content") {
//                    MetalContentView()
                    PlatformViewControllerRepresent(MetalContentViewController())
                }
                NavigationLink("Trangle") {
//                    MetalTrangleView()
                    PlatformViewControllerRepresent(MetalTrangleViewController())
                        .overlay {
                            GeometryReader { geometry in
                                Text("width:\(geometry.size.width), height:\(geometry.size.height)")
                            }
                        }
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

