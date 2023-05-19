//
//  BundleResourcesView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/9.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct BundleResourcesView: View {
    var body: some View {
        Image("AppIcon")
        List {
            ForEach(InformationPropertyListKey.allCases) { item in
                Button(item.rawValue) {
                    let dic = Bundle.main.infoDictionary
                    let i = dic?["CFBundleIcons"]
                    print(i ?? "nil")
                }
            }
        }
    }
}

struct BundleResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        BundleResourcesView()
    }
}
