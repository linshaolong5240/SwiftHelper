//
//  SwiftUISliderView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/11.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUISliderView: View {
    @State private var value: Float = 50
    var body: some View {
        List {
            Slider(value: $value, in: 1...100)
            Slider(value: $value, in: 1...100, step: 10)
            Slider(value: $value, in: 1...100, step: 10, label: {Text("value")}, minimumValueLabel: {Text("1")}, maximumValueLabel: {Text("100")})

        }
    }
}

struct SwiftUISliderView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUISliderView()
    }
}
