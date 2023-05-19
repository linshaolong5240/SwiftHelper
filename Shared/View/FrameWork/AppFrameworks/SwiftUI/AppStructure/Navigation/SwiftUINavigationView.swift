//
//  SwiftUINavigationView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/2/21.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUINavigationView: View {
    var body: some View {
        List {
            NavigationLink("TableView") {
                SwiftUITableViewView()
            }
        }
    }
}

struct SwiftUINavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUINavigationView()
    }
}
