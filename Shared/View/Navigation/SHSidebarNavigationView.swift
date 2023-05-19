//
//  SHSidebarNavigationView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/29.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SHSidebarNavigationView: View {
    @State private var selection: SHHomeNavigationItem? = .tool
    
    var body: some View {
        NavigationSplitView {
            List(SHHomeNavigationItem.allCases, id: \.self, selection: $selection) { item in
                Text(item.name)
            }
        } content: {
            if let value = selection {
                switch value {
                case .tool:
                    SPToolHomeView()
                case .feature:
                    SPFeatureHomeView()
                case .framework:
                    FrameworkHomeView()
                case .languageInteroperability:
                    SPLanguageInteroperabilityView()
                }
            } else {
                EmptyView()
            }
        } detail: {
            Text("Detail")
        }
//        NavigationView {
//            List {
//                NavigationLink {
//                    ThirdPartyHomeView()
//                } label: {
//                    HStack {
//                        Image(systemName: "swift")
//                        Text("SwiftPackage")
//                    }
//                }
//            }
//        }
    }
}

#if DEBUG
struct SHSidebarNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SHSidebarNavigationView()
    }
}
#endif
