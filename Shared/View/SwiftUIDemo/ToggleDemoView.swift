//
//  ToggleDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct ToggleDemoView: View {
    @State private var isOn: Bool = false
    var body: some View {
        List {
            Toggle(isOn: $isOn) {
                Text("With Lable")
            }
            if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                Toggle(isOn: $isOn) {
                    Text("Custom Tint Color")
                }
                .tint(.orange)
            } else {
                Toggle(isOn: $isOn) {
                    Text("Custom Tint Color")
                }
                .toggleStyle(SwitchToggleStyle(tint: .orange))
            }
            Toggle(isOn: $isOn) {
                Text("Fixed Size")
            }.fixedSize()
            
        }
    }
}

#if DEBUG
struct ToggleDemo_Previews: PreviewProvider {
    static var previews: some View {
        ToggleDemoView()
    }
}
#endif
