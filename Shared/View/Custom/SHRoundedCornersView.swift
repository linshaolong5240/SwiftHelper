//
//  SHRoundedCornersView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/4/20.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SHRoundedCornersView: View {
    var topLeftRadius: CGFloat = 0.0
    var topRightRadius: CGFloat = 0.0
    var bottomLeftRadius: CGFloat = 0.0
    var bottomRightRadius: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path.RoundedCornersPath(size: geometry.size, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        }
    }
}

struct SHRoundedCornersViewDemo: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                GeometryReader { geometry in
                    Path.RoundedCornersPath(size: geometry.size, topLeftRadius: 30, topRightRadius: 0, bottomLeftRadius: 0, bottomRightRadius: 30)
                }
                .frame(width: 50, height: 50)
                .overlay(
                    GeometryReader { geometry in
                        Path.RoundedCornersPath(size: geometry.size, topLeftRadius: 30, topRightRadius: 0, bottomLeftRadius: 0, bottomRightRadius: 30)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.pink, .green]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .offset(x: -5, y: -5)
                    }
                )
                GeometryReader { geometry in
                    Path.RoundedCornersPath(size: geometry.size, topLeftRadius: 25, topRightRadius: 25, bottomLeftRadius: 0, bottomRightRadius: 0)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.pink, .green]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .background(Color.blue)
                }
                .frame(width: 200, height: 50)
                
                GeometryReader { geometry in
                    Path.RoundedCornersPath(size: geometry.size, topLeftRadius: 0, topRightRadius: 0, bottomLeftRadius: 25, bottomRightRadius: 25)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.pink, .green]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .background(Color.blue)
                }
                .frame(width: 200, height: 50)
                
            }
        }
    }
}

#if DEBUG
struct SHRoundedCornersView_Previews: PreviewProvider {
    static var previews: some View {
        SHRoundedCornersViewDemo()
    }
}
#endif
