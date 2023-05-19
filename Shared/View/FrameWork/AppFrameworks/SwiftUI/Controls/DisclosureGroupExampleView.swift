//
//  DisclosureGroupExampleView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/18.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

fileprivate struct ToggleStates {
    var oneIsOn: Bool = false
    var twoIsOn: Bool = true
}

struct DisclosureGroupExampleView: View {
    @State private var toggleStates = ToggleStates()
    @State private var topExpanded: Bool = true

    var body: some View {
        VStack {
            DisclosureGroup("Items", isExpanded: $topExpanded) {
                Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                DisclosureGroup("Sub-items") {
                    Text("Sub-item 1")
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct DisclosureGroupExampleView_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureGroupExampleView()
    }
}
