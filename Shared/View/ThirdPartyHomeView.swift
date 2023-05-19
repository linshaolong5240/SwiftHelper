//
//  ThirdPartyHomeView.swift
//  SwiftHelper
//
//  Created by Sauron on 2023/5/20.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct ThirdPartyHomeView: View {
    var body: some View {
        List {
            Section("UI") {
                NavigationLink("CoderMJLee/MJRefresh") {
                    SPWebView(url: URL(string: "https://github.com/CoderMJLee/MJRefresh")!)
                }
            }
            Section("Animations") {
                NavigationLink("simibac/ConfettiSwiftUI") {
                    SPWebView(url: URL(string: "https://github.com/simibac/ConfettiSwiftUI")!)
                }
            }
            Section("Keyboard") {
                NavigationLink("IQKeyboardManagerSwift") {
                    #if os(iOS)
                    PlatformViewControllerRepresent(IQKeyboardManagerSwiftViewController())
                    #else
                    PlatformOnlyView(platform: .iOS)
                    #endif
                }
                NavigationLink("hackiftekhar/IQKeyboardManager") {
                    SPWebView(url: URL(string: "https://github.com/hackiftekhar/IQKeyboardManager")!)
                }
            }
            Section("Persistent Storage") {
                NavigationLink("SQLiteSwift") {
                    SQLiteSwiftDemoView()
                }
            }
        }
    }
}

struct ThirdPartyHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdPartyHomeView()
    }
}
