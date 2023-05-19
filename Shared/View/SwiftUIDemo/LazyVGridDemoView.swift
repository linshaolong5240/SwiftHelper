//
//  LazyVGridDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct LazyVGridDemoView: View {
    var body: some View {
        VStack {
            let columns: [GridItem] =
                    Array(repeating: .init(.flexible()), count: 2)
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach((0...79), id: \.self) {
                        let codepoint = $0 + 0x1f600
                        let codepointString = String(format: "%02X", codepoint)
                        Text("\(codepointString)")
                        let emoji = String(Character(UnicodeScalar(codepoint)!))
                        Text("\(emoji)")
                    }
                }.font(.largeTitle)
            }
        }
    }
}

struct LazyVGridDemo_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGridDemoView()
    }
}
