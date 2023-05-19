//
//  SwiftUITableViewView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/2/21.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUITableViewView: View {
    var body: some View {
        TabView {
            Text("View 1")
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            Text("View 2")
                .tabItem {
                    Label("Account", systemImage: "person")
                }

            Text("View 3")
                .tabItem {
                    Label("Community", systemImage: "theatermasks")
                }
        }
    }
}

struct SwiftUITableViewView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITableViewView()
    }
}
