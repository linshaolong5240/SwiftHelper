//
//  ContentView.swift
//  Shared
//
//  Created by sauron on 2021/11/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
#endif
    
    init() {
#if canImport(UIKit)
        let appearance: UITabBarAppearance = UITabBarAppearance()
        //        appearance.backgroundEffect = nil
        //        appearance.backgroundColor = #colorLiteral(red: 0.1511307359, green: 0.1317227483, blue: 0.2523903847, alpha: 1)
        //        appearance.shadowColor = nil
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
#endif
    }
    
    var body: some View {
        ZStack {
#if os(iOS)
            if horizontalSizeClass == .compact {
                SHTabNavigationView()
            } else {
                SHSidebarNavigationView()
            }
#endif
        
#if os(macOS)
        SHSidebarNavigationView()
#endif
        
#if false
        SHDEBUGView()
#endif
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
