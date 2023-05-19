//
//  WidgetMeidumPostionView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/3/7.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WidgetMeidumPostionView: View {
    var body: some View {
        ZStack {
            switch UIScreen.screenType {
            case .iPhone_428_926:
                widget_medium_428_926()
            case .iPhone_414_896:
                widget_medium_414_896()
            case .iPhone_414_736:
                widget_medium_414_736()
            case .iPhone_390_844:
                widget_medium_390_844()
            case .iPhone_375_812:
                widget_medium_375_812()
            case .iPhone_375_667:
                widget_medium_375_667()
            case .iPhone_360_780_375_812_mini:
                widget_medium_360_780()
            case .iPhone_320_568:
                widget_medium_320_580()
            case .unknown:
                EmptyView()
            }
        }
        .ignoresSafeArea()
        .overlay(
            VStack {
                Text("screenWidth: \(UIScreen.main.bounds.width) \(UIScreen.main.nativeBounds.size.width)")
                Text("screenHeight: \(UIScreen.main.bounds.height) \(UIScreen.main.nativeBounds.size.height)")
            }.foregroundColor(.orange)
        )
    }
    
    func widget_medium_428_926() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_medium_428_926")
            RectInfoRectangle(title: "Top")
                .offset(x: 32, y: 82)
            RectInfoRectangle(title: "Middle")
                .offset(x: 32, y: 294)
            RectInfoRectangle(title: "Bottom")
                .offset(x: 32, y: 506)
        }
    }
    
    func widget_medium_414_896() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_medium_414_896")
            RectInfoRectangle(title: "Top")
                .offset(x: 27, y: 76)
            RectInfoRectangle(title: "Middle")
                .offset(x: 27, y: 286)
            RectInfoRectangle(title: "Bottom")
                .offset(x: 27, y: 496)
        }
    }
    
    func widget_medium_414_736() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_medium_414_736")
            RectInfoRectangle(title: "Top")
                .offset(x: 33, y: 38)
            RectInfoRectangle(title: "Middle")
                .offset(x: 33, y: 232)
            RectInfoRectangle(title: "Bottom")
                .offset(x: 33, y: 426)
        }
    }
    
    func widget_medium_390_844() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_medium_390_844")
            RectInfoRectangle(title: "Top")
                .offset(x: 26, y: 77)
            RectInfoRectangle(title: "Middle")
                .offset(x: 26, y: 273)
            RectInfoRectangle(title: "Bottom")
                .offset(x: 26, y: 469)
        }
    }
    
    func widget_medium_375_812() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_medium_375_812")
            RectInfoRectangle(title: "Top")
                .offset(x: 23, y: 71)
            RectInfoRectangle(title: "Middle")
                .offset(x: 23, y: 261)
            RectInfoRectangle(title: "Bottom")
                .offset(x: 23, y: 451)
        }
    }
    
    func widget_medium_375_667() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_medium_375_667")
            RectInfoRectangle(title: "Top")
                .offset(x: 27, y: 30)
            RectInfoRectangle(title: "Middle")
                .offset(x: 27, y: 206)
            RectInfoRectangle(title: "Bottom")
                .offset(x: 27, y: 382)
        }
    }
    
    func widget_medium_360_780() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_medium_360_780")
            RectInfoRectangle(title: "Top")
                .offset(x: 22, y: 74)
            RectInfoRectangle(title: "Medium")
                .offset(x: 22, y: 256)
            RectInfoRectangle(title: "Bottom")
                .offset(x: 22, y: 439)
        }
    }
    
    func widget_medium_320_580() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_medium_320_580")
            RectInfoRectangle(title: "Top")
                .offset(x: 14, y: 30)
            RectInfoRectangle(title: "Middle")
                .offset(x: 14, y: 200)
        }
    }
    
    func RectInfoRectangle(title: String) -> some View {
        Rectangle()
            .opacity(0.5)
            .frame(width: WidgetFamily.systemMedium.size.width, height: WidgetFamily.systemMedium.size.height)
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

struct WidgetMeidumPostionView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetMeidumPostionView()
    }
}
