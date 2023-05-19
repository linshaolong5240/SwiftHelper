//
//  UIKitView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/16.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct UIKitView: View {
    var body: some View {
        List {
            Section("UserInterface") {
                NavigationLink("Views and Controls") {
                    UIKitViewsAndControlsView()
                }
            }
        }
    }
}

struct UIKitView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UIKitView()
        }
    }
}
