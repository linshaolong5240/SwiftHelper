//
//  ScrollViewDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/5/19.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct ScrollViewDemoView: View {
    private let colors: [Color] = [.red, .green, .blue, .yellow, .pink ,.orange] + [.red, .green, .blue, .yellow, .pink ,.orange] + [.red, .green, .blue, .yellow, .pink ,.orange]
    var body: some View {
        ScrollViewReader { proxy in
            HStack {
                ForEach(Array(colors.enumerated()), id: \.offset) { index, item in
                    Button {
                        proxy.scrollTo(index, anchor: .top)
                    } label: {
                        item
                            .frame(width: 50,height: 50)
                            .overlay(
                                Text("index: \(index)")
                            )
                    }
                }
            }
            .frame(height: 50)
            ScrollView {
                ForEach(Array(colors.enumerated()), id: \.offset) { index, item in
                    item
                        .frame(height: 100)
                        .overlay(
                            Text("index: \(index)")
                        )
                        .id(index)
                }
            }
        }
    }
}

#if DEBUG
struct ScrollViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewDemoView()
    }
}
#endif
