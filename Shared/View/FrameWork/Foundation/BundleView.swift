//
//  BundleView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/9.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct BundleView: View {
    @State private var bundleInfo: String = ""
    
    var body: some View {
        List {
            Section("Bundle Idnetifier") {
                Text("baseBundleIdentifier: \(Bundle.baseBundleIdentifier)")
                Text("sharedContainerIdentifier: \(Bundle.sharedContainerIdentifier)")
            }
            Divider()
            Text("Bundle Info:")
            TextEditor(text: $bundleInfo)
        }
        .onAppear {
            guard bundleInfo == "" else {
                return
            }
            getBundleInfo()
        }
    }
    
    private func getBundleInfo() {
        bundleInfo = Bundle.main.infoDictionary?.description ?? "nil"
    }
}

struct BundleView_Previews: PreviewProvider {
    static var previews: some View {
        BundleView()
    }
}
