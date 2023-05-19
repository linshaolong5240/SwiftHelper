//
//  SliderDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/26.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SliderDemoView: View {
    @State private var speed = 50.0
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            Slider(
                value: $speed,
                in: 0...100,
                step: 5
            ) {
                Text("Speed")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            } onEditingChanged: { editing in
                isEditing = editing
        }
            Text("\(speed)")
                .foregroundColor(isEditing ? .red : .blue)
        }
    }
}

struct SliderDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SliderDemoView()
    }
}
