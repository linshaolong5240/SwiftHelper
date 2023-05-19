//
//  SHRollingNumber.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/26.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SHRollingNumber: View {
    let font: Font
    @Binding var value: Int
    @State private var animationRange: [Int] = []
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<animationRange.count, id: \.self) { item in
                Text("8")
                    .font(font)
                    .opacity(0)
                    .overlay(
                        GeometryReader { geometry in
                            let size = geometry.size
                            VStack(spacing: 0) {
                                ForEach(0...9, id: \.self) { item in
                                    Text("\(item)")
                                        .font(font)
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                }
                            }
                            .offset(y: -CGFloat(animationRange[item]) * size.height)
                        }
                        .clipped()
                    )
            }
        }
        .onAppear {
            if animationRange.isEmpty {
                animationRange = Array(repeating: 0, count: "\(value)".count)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    updateText()
                }
            }
        }
        .onChange(of: value) { newValue in
            let delta = String(value).count - animationRange.count
            if delta > 0 {
                for _ in 0..<delta {
                    let _ =  withAnimation(.easeIn(duration: 0.1)) {
                        animationRange.insert(0, at: 0)
                    }
                }
            } else {
                for _ in 0..<(-delta) {
                    let _ = withAnimation(.easeIn(duration: 0.1)) {
                        animationRange.removeFirst()
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                updateText()
            }
        }
    }
    
    func updateText() {
        let stringValue = "\(value)"
        for (index, value) in zip(0..<stringValue.count, stringValue) {
            let fraction = min(Double(index) * 0.15, 1.5)
            
            withAnimation(.spring(response: 0.8, dampingFraction: 1 + fraction, blendDuration: 1 + fraction)) {
                animationRange[index] = Int(String(value)) ?? 0
            }
        }
    }
}

struct SHRollingNumberDemoView: View {
    @State private var value: Int = 100
    
    var body: some View {
        VStack {
            SHRollingNumber(font: .system(size: 60, weight: .bold), value: $value)
            
            Button {
                value = Int.random(in: 1000...95000)
            } label: {
                Text("Random Number: \(value)")
            }
        }
    }
}

#if DEBUG
struct SHRollingNumber_Previews: PreviewProvider {
    static var previews: some View {
        SHRollingNumberDemoView()
    }
}
#endif
