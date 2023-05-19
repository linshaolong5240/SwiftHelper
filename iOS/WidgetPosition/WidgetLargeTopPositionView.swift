//
//  WidgetLargeTopPositionView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/3/7.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WidgetLargeTopPositionView: View {
    var body: some View {
        ZStack {
            switch UIScreen.screenType {
            case .iPhone_428_926:
                widget_large_428_926()
            case .iPhone_414_896:
                widget_large_414_896()
            case .iPhone_414_736:
                widget_large_414_736()
            case .iPhone_390_844:
                widget_large_390_844()
            case .iPhone_375_812:
                widget_large_375_812()
            case .iPhone_375_667:
                widget_large_375_667()
            case .iPhone_360_780_375_812_mini:
                widget_large_360_780()
            case .iPhone_320_568:
                widget_large_320_580()
            case .unknown:
                EmptyView()
            }
        }
        .ignoresSafeArea()
        .overlay(
            VStack {
                Text("screenWidth: \(UIScreen.main.bounds.width)")
                Text("screenHeight: \(UIScreen.main.bounds.height)")
            }.foregroundColor(.orange)
        )
    }
    
    func widget_large_428_926() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_428_926_top")
            RectInfoRectangle(title: "Top")
                .offset(x: 32, y: 82)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_414_896() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_414_896_top")
            RectInfoRectangle(title: "Top")
                .offset(x: 27, y: 76)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_414_736() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_414_736_top")
            RectInfoRectangle(title: "Top")
                .offset(x: 33, y: 38)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_390_844() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_390_844_top")
            RectInfoRectangle(title: "Top")
                .offset(x: 26, y: 77)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_375_812() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_375_812_top")
            RectInfoRectangle(title: "Top")
                .offset(x: 23, y: 71)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_375_667() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_375_667_top")
            RectInfoRectangle(title: "Top")
                .offset(x: 27, y: 30)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_360_780() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_360_780_top")
            RectInfoRectangle(title: "Top")
                .offset(x: 22, y: 74)
        }
        .ignoresSafeArea()
    }
    
    func widget_large_320_580() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_large_320_580_top")
            RectInfoRectangle(title: "Top")
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

struct WidgetLargePositionView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetLargeTopPositionView()
    }
}
