//
//  GradientDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/5/20.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct GradientDemoView: View {
    private let colors = [Color( #colorLiteral(red: 0.3083391786, green: 0.8287974, blue: 0.986125052, alpha: 1)), Color( #colorLiteral(red: 0.9498698115, green: 0.3867799342, blue: 0.9902347922, alpha: 1)), Color( #colorLiteral(red: 0.9949889779, green: 0.6915814877, blue: 0.2030524313, alpha: 1))]
    var body: some View {
        ScrollView {
            AngularGradient(gradient: Gradient(colors: colors), center: .center)
                .frame(width: 200, height: 200)
            if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
                EllipticalGradient(colors: colors, center: .center, startRadiusFraction: 0.0, endRadiusFraction: 0.5)
                    .frame(width: 200, height: 200)
            }
            LinearGradient(gradient: Gradient(colors: colors), startPoint: .bottomLeading, endPoint: .topTrailing)
                .frame(width: 200, height: 200)
            RadialGradient(gradient: Gradient(colors: colors), center: .center, startRadius: 0, endRadius: 100)
                .frame(width: 200, height: 200)
        }
    }
}

#if DEBUG
struct LinearGradientDemo_Previews: PreviewProvider {
    static var previews: some View {
        GradientDemoView()
    }
}
#endif
