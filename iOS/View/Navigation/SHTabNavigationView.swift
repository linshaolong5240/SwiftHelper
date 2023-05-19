//
//  SHTabNavigationView.swift
//  SwiftHelper
//
//  Created by sauron on 2021/12/4.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SHTabNavigationView: View {
#if canImport(UIKit)
    @EnvironmentObject var appDelegate: AppDelegate
#endif
    
    @State private var selection: SHHomeNavigationItem = .tool
    @State private var showChargingAnimation: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
#if canImport(UIKit)
                NavigationLink(isActive: $showChargingAnimation) {
                    PlatformViewControllerRepresent(ChargingAnimationViewController())
                        .ignoresSafeArea()
                } label: {
                    EmptyView()
                }
#endif
                
                TabView(selection: $selection) {
                    //                    SPToolHomeView()
                    //                        .tabItem {
                    //                            Image(systemName: "swift")
                    //                            Text(TabBarItemTpye.tool.name)
                    //                        }
                    //                        .tag(TabBarItemTpye.tool)
                    SPFeatureHomeView()
                        .tabItem {
                            Image(systemName: "swift")
                            Text(SHHomeNavigationItem.feature.name)
                        }
                        .tag(SHHomeNavigationItem.feature)
                    FrameworkHomeView()
                        .tabItem {
                            Image(systemName: "swift")
                            Text(SHHomeNavigationItem.framework.name)
                        }
                        .tag(SHHomeNavigationItem.framework)
//                    ThirdPartyHomeView()
//                        .tabItem {
//                            Image(systemName: "swift")
//                            Text(SHHomeNavigationItem.swiftPackage.name)
//                        }
//                        .tag(SHHomeNavigationItem.swiftPackage)
                }
            }
        }
#if canImport(UIKit)
        .onContinueUserActivity(NSUserActivity.chargingAnimationActivityType) { userActive in
            showChargingAnimation.toggle()
        }
#endif
    }
}

#if DEBUG
struct SHTabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SHTabNavigationView()
    }
}
#endif
