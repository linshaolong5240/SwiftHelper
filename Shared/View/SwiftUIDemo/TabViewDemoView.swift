//
//  TabViewDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/6/1.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct TabViewDemoView: View {
    let data: [Color] = [.red, .green, .blue]
    @State private var selection: Int = 0

    var body: some View {
        ZStack {
            data[selection]
            TabView(selection: $selection) {
                ForEach(data.indices, id: \.self) { index in
                    data[index]
                        .tabItem { Text("Tab Label \(index)") }.tag(index)
                }
            }
            #if os(iOS)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            #endif
            .frame(width: 200, height: 200)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
        .navigationTitle("TabView")
    }
}

#if DEBUG
struct TabViewDemoView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewDemoView()
    }
}
#endif
