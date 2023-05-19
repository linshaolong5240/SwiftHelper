//
//  PickerDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/5/5.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct PickerDemoView: View {
    private let data = Array(1...50).map({ $0 * 1000 })
    @State private var selection: Int = 1000
    
    var body: some View {
        VStack {
            Text("\(selection)")
            Picker("Picker", selection: $selection) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                    Text("\(item)")
                    .padding(.horizontal)
                    .tag(item)
                }
            }
            #if canImport(UIKit)
            .pickerStyle(WheelPickerStyle())
            #endif
            
            Picker("Picker", selection: $selection) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                    Text("\(item)")
                    .padding(.horizontal)
                    .tag(item)
                }
            }
            .pickerStyle(.inline)
        }
    }
}

#if DEBUG
struct PickerDemo_Previews: PreviewProvider {
    static var previews: some View {
        PickerDemoView()
    }
}
#endif
