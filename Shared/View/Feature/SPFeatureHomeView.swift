//
//  SPFeatureHomeView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/25.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SPFeatureHomeView: View {
    var body: some View {
        List {
            #if canImport(UIKit)
            NavigationLink("Charging Anamation") { 
                PlatformViewControllerRepresent(ChargingAnimationViewController())
                    .ignoresSafeArea()
                    .onContinueUserActivity(NSUserActivity.chargingAnimationActivityType) { userActivity in
                        
                    }
            }
            NavigationLink("Piture In Picture Demo") {
                PlatformViewControllerRepresent(UIPictureInPictureViewController())
            }
            #endif
            #if os(iOS)
            NavigationLink("SHCommentTableViewController") {
                PlatformViewControllerRepresent(SHCommentTableViewController()).ignoresSafeArea()
            }
            NavigationLink("SUITableViewCell") {
                PlatformViewControllerRepresent(SUITableViewCellDemoController()).ignoresSafeArea()
            }
            NavigationLink("SHImageCollectionViewController") {
                PlatformViewControllerRepresent(SHImageCollectionViewController()).ignoresSafeArea()
            }
            #endif
            Section("QR Code") {
                #if os(iOS)
                NavigationLink("QR Code") {
                    SHQRCodeGenerateiew(message: "https://www.baidu.com")
                }
                NavigationLink("QR Code Detect") {
                    SHQRCodeDetectView()
                }
                NavigationLink("QR Code Scaner") {
                    PlatformViewControllerRepresent(SHQRCodeScanerViewController()).ignoresSafeArea()
                }

                #endif
            }
        }
        .navigationTitle("Feature")
    }
}

#if DEBUG
struct FeatureHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SPFeatureHomeView()
    }
}
#endif
