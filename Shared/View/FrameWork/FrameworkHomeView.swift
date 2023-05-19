//
//  FrameworkHomeView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/6/29.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct FrameworkHomeView: View {
    @State private var showAlert: Bool = false
    
    var body: some View {
        List {
            Section("other") {
                NavigationLink("WebKit") {
                    SPWebView(url: URL(string: "https://www.baidu.com")!)
    //                WebView()
                }
                NavigationLink("ThirdPartyHomeView") {
                    ThirdPartyHomeView()
                }
            }

            Section {
                NavigationLink("Bundle Resources") {
                    BundleResourcesView()
                }
                NavigationLink("CoreLocation") {
                    CoreLocationDemoView()
                }
                NavigationLink("Foundation") {
                    FoundationFrameworkView()
                }
                NavigationLink("SwiftUI") {
                    SwiftUIFrameworkView()
                }
#if canImport(UIKit)
                NavigationLink("UIKit") {
                    UIKitView()
                }
#endif
            } header: {
                Text("App Framework")
            }
            
            Section {
                #if os(iOS)
                NavigationLink("WidgetKit") {
                    WidgetHomeView()
                }
                #endif
                NavigationLink("Contacts") {
                    ContactsDemoView()
                }
                NavigationLink("ContactsUI") {
                    ContactsUIDemoView()
                }
                NavigationLink("Vision") {
                    VisionFrameworkView()
                }
            } header: {
                Text("App Services")
            }
            
            Section {
                NavigationLink("CoreGraphicsFramework") {
                    CoreGraphicsFrameworkView()
                }
                NavigationLink("Core Image") {
                    CoreImageFrameworkView()
                }
                NavigationLink("Image I/O") {
                    ImageIOFrameworkView()
                }
                NavigationLink("Metal") {
                    MetalFrameworkView()
                }
            } header: {
                Text("Graphics and Games")
            }
            
            Section {
                NavigationLink("Network") {
                    NetworkFrameworkView()
                }
            } header: {
                Text("System")
            }
        }
        .navigationTitle("Framework")
    }
}

#if DEBUG
struct FrameworkHomeView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkHomeView()
    }
}
#endif
