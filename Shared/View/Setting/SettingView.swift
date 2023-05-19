//
//  SettingView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/12/29.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        List {
            Button {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    // Ask the system to open that URL.
                    UIApplication.shared.open(url)
                }
            } label: {
                Text("Open App Settings")
            }
            
            Button {
                if #available(iOS 16.0, *) {
                    if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                        // Ask the system to open that URL.
                        UIApplication.shared.open(url)
                    }
                } else {
                    // Fallback on earlier versions
                }
            } label: {
                Text("Open Notification Settings")
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
