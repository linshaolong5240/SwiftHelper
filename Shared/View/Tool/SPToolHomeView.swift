//
//  SPToolHomeView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/5/1.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SPToolHomeView: View {
    var body: some View {
        List {
            NavigationLink("App Icon") {
                SPCurrentAppIconView()
            }
            #if canImport(AppKit)
            NavigationLink {
                SHMD5HelperView()
            } label: {
                Text("MD5 Helper")
            }
            #endif
            NavigationLink("App Icon Generator") {
                SPAppIconGeneraterView()
            }
            NavigationLink(destination: SwiftUIViewExportDemo()) {
                Text("SwiftUIViewExport")
            }
            NavigationLink("AFAPI") {
                AFAPIDemoView()
            }
            NavigationLink("SHAPI") {
                SHAPIDemoView()
            }
        }
        .navigationTitle("Tool")
    }
}

#if DEBUG
struct ToolHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SPToolHomeView()
    }
}
#endif
