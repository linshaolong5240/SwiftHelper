//
//  SwiftUIButtonView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/2/21.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUIButtonView: View {
    @State private var isOn = false

    var body: some View {
        List {
            Section {
                Button("ButtonRole: cancel", role: .cancel) {
                    print("Perform cancel")
                }
                Button("ButtonRole: destructive", role: .destructive) {
                    print("Perform destructive")
                }
            } header: {
                Text("Button")
            }
            Section {
                Toggle("toggleStyle: automatic", isOn: $isOn)
                    .toggleStyle(.automatic)
                    .tint(.accentColor)
                #if os(macOS)
                Toggle("toggleStyle: button", isOn: $isOn)
                    .toggleStyle(.checkbox)
                    .tint(.accentColor)
                #endif
                Toggle("toggleStyle: switch", isOn: $isOn)
                    .toggleStyle(.switch)
                    .tint(.accentColor)
                Toggle("toggleStyle: button", isOn: $isOn)
                    .toggleStyle(.button)
                    .tint(.accentColor)
            } header: {
                Text("Toggle")
            }
        }
    }
}

struct SwiftUIButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIButtonView()
    }
}
