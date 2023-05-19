//
//  AnimationSpringDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/26.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct AnimationSpringDemoView: View {
    @State private var response: Double = 1.0
    @State private var dampingFraction: Double = 0.1
    @State private var blendDuration: Double = 0.1

    @State private var animated: Bool = false
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.orange)
                .scaleEffect(animated ? 0.5 : 1.0, anchor: .center)
                .padding()
            HStack {
                Text("response: \(String(format: "%.2f", response))")
                Slider(
                        value: $response,
                        in: 0...10,
                        step: 0.1
                    ) {
                        Text("response")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("10")
                    } onEditingChanged: { editing in
    //                    isEditing = editing
                }
            }
            HStack {
                Text("dampingFraction: \(String(format: "%.2f", dampingFraction))")
                Slider(
                        value: $dampingFraction,
                        in: 0...1,
                        step: 0.1
                    ) {
                        Text("dampingFraction")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("1")
                    } onEditingChanged: { editing in
    //                    isEditing = editing
                }
            }
            HStack {
                Text("blendDuration: \(String(format: "%.2f", blendDuration))")
                Slider(
                        value: $blendDuration,
                        in: 0...1,
                        step: 0.1
                    ) {
                        Text("blendDuration")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("1")
                    } onEditingChanged: { editing in
    //                    isEditing = editing
                }
            }
            Button {
                withAnimation(.spring(response: response, dampingFraction: dampingFraction, blendDuration: blendDuration)) {
                    animated.toggle()
                }
            } label: {
                Text("Animate")
            }
        }
    }
}

#if DEBUG
struct AnimationSpringDemoView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationSpringDemoView()
    }
}
#endif
