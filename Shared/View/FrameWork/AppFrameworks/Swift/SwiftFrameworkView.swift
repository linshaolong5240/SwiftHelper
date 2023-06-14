//
//  SwiftFrameworkView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/9.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftFrameworkView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("MemoryLayout") {
                    SwiftMemoryLayoutView()
                }
                NavigationLink("Result Build") {
                    SwiftResultBuildView()
                }
            }
        }
    }
}

struct SwiftFrameworkView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftFrameworkView()
    }
}
