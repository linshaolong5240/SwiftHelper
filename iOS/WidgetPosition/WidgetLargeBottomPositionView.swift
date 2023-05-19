//
//  WidgetLargeBottomPositionView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/3/7.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WidgetLargeBottomPositionView: View {
    var body: some View {
                widget_large_428_926()
//                widget_large_414_896()
//                widget_large_414_736()
//                widget_large_390_844()
//                widget_large_375_812()
//                widget_large_375_667()
//                widget_large_360_780()
//        widget_large_320_580()
            .overlay(
                VStack {
                    Text("screenWidth: \(UIScreen.main.bounds.width)")
                    Text("screenHeight: \(UIScreen.main.bounds.height)")
                }.foregroundColor(.orange)
            )
    }
    
    func widget_large_428_926() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_428_926_bottom")
            RectInfoRectangle(title: "Bottom")
                .offset(x: 32, y: 294)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_414_896() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_414_896_bottom")
            RectInfoRectangle(title: "Bottom")
                .offset(x: 27, y: 286)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_414_736() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_414_736_bottom")
            RectInfoRectangle(title: "Bottom")
                .offset(x: 33, y: 232)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_390_844() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_390_844_bottom")
            RectInfoRectangle(title: "Bottom")
                .offset(x: 26, y: 273)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_375_812() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_375_812_bottom")
            RectInfoRectangle(title: "Bottom")
                .offset(x: 23, y: 261)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_375_667() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_375_667_bottom")
            RectInfoRectangle(title: "Bottom")
                .offset(x: 27, y: 206)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_360_780() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_360_780_bottom")
            RectInfoRectangle(title: "Bottom")
                .offset(x: 22, y: 256.5)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_320_580() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_320_580_bottom")
            RectInfoRectangle(title: "Bottom")
                .offset(x: 14, y: 30)
        }
        .ignoresSafeArea()
    }
    
    func RectInfoRectangle(title: String) -> some View {
        Rectangle()
            .opacity(0.5)
            .frame(width: WidgetFamily.systemLarge.size.width, height: WidgetFamily.systemLarge.size.height)
            .overlay(
                GeometryReader { geometry in
                    VStack {
                        Text(title)
                        Text(geometry.frame(in: .global).debugDescription)
                    }
                    .foregroundColor(.orange)
                }
            )
    }

}

struct WidgetLargeBottomPositionView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetLargeBottomPositionView()
    }
}
