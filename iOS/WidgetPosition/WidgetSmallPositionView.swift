//
//  WidgetSmallPositionView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/3/3.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WidgetSmallPositionView: View {
    var body: some View {
        ZStack {
            switch UIScreen.screenType {
            case .iPhone_428_926:
                widget_small_428_926()
            case .iPhone_414_896:
                widget_small_414_896()
            case .iPhone_414_736:
                widget_small_414_736()
            case .iPhone_390_844:
                widget_small_390_844()
            case .iPhone_375_812:
                widget_small_375_812()
            case .iPhone_375_667:
                widget_small_375_667()
            case .iPhone_360_780_375_812_mini:
                widget_small_360_780()
            case .iPhone_320_568:
                widget_small_320_580()
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
    
    func widget_small_428_926() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_small_428_926")
            RectInfoRectangle(title: "Top Leading")
                .offset(x: 32, y: 82)
            RectInfoRectangle(title: "Top Trail")
                .offset(x: 226, y: 82)
            RectInfoRectangle(title: "Middle Leading")
                .offset(x: 32, y: 294)
            RectInfoRectangle(title: "Middle Trail")
                .offset(x: 226, y: 294)
            RectInfoRectangle(title: "Bottom Leading")
                .offset(x: 32, y: 506)
            RectInfoRectangle(title: "Bottom Trail")
                .offset(x: 226, y: 506)
        }
        .ignoresSafeArea()
    }
    
    func widget_small_414_896() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_small_414_896")
            RectInfoRectangle(title: "Top Leading")
                .offset(x: 27, y: 76)
            RectInfoRectangle(title: "Top Trail")
                .offset(x: 218, y: 76)
            RectInfoRectangle(title: "Middle Leading")
                .offset(x: 27, y: 286)
            RectInfoRectangle(title: "Middle Trail")
                .offset(x: 218, y: 286)
            RectInfoRectangle(title: "Bottom Leading")
                .offset(x: 27, y: 496)
            RectInfoRectangle(title: "Bottom Trail")
                .offset(x: 218, y: 496)
        }
        .ignoresSafeArea()
    }
    
    func widget_small_414_736() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_small_414_736")
            RectInfoRectangle(title: "Top Leading")
                .offset(x: 33, y: 38)
            RectInfoRectangle(title: "Top Trail")
                .offset(x: 224, y: 38)
            RectInfoRectangle(title: "Middle Leading")
                .offset(x: 33, y: 232)
            RectInfoRectangle(title: "Middle Trail")
                .offset(x: 224, y: 232)
            RectInfoRectangle(title: "Bottom Leading")
                .offset(x: 33, y: 426)
            RectInfoRectangle(title: "Bottom Trail")
                .offset(x: 224, y: 426)
        }
        .ignoresSafeArea()
    }
    
    func widget_small_390_844() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_small_390_844")
            RectInfoRectangle(title: "Top Leading")
                .offset(x: 26, y: 77)
            RectInfoRectangle(title: "Top Trail")
                .offset(x: 206, y: 77)
            RectInfoRectangle(title: "Middle Leading")
                .offset(x: 26, y: 273)
            RectInfoRectangle(title: "Middle Trail")
                .offset(x: 206, y: 273)
            RectInfoRectangle(title: "Bottom Leading")
                .offset(x: 26, y: 469)
            RectInfoRectangle(title: "Bottom Trail")
                .offset(x: 206, y: 469)
        }
        .ignoresSafeArea()
    }
    
    func widget_small_375_812() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_small_375_812")
            RectInfoRectangle(title: "Top Leading")
                .offset(x: 23, y: 71)
            RectInfoRectangle(title: "Top Trail")
                .offset(x: 197, y: 71)
            RectInfoRectangle(title: "Middle Leading")
                .offset(x: 23, y: 261)
            RectInfoRectangle(title: "Middle Trail")
                .offset(x: 197, y: 261)
            RectInfoRectangle(title: "Bottom Leading")
                .offset(x: 23, y: 451)
            RectInfoRectangle(title: "Bottom Trail")
                .offset(x: 197, y: 451)
        }
        .ignoresSafeArea()
    }
    
    func widget_small_375_667() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_small_375_667")
            RectInfoRectangle(title: "Top Leading")
                .offset(x: 27, y: 30)
            RectInfoRectangle(title: "Top Trail")
                .offset(x: 200, y: 30)
            RectInfoRectangle(title: "Middle Leading")
                .offset(x: 27, y: 206)
            RectInfoRectangle(title: "Middle Trail")
                .offset(x: 200, y: 206)
            RectInfoRectangle(title: "Bottom Leading")
                .offset(x: 27, y: 382)
            RectInfoRectangle(title: "Bottom Trail")
                .offset(x: 200, y: 382)
        }
        .ignoresSafeArea()
    }
    
    func widget_small_360_780() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_small_360_780")
            RectInfoRectangle(title: "Top Leading")
                .offset(x: 22, y: 74)
            RectInfoRectangle(title: "Top Trail")
                .offset(x: 189, y: 74)
            RectInfoRectangle(title: "Middle Leading")
                .offset(x: 22, y: 256.4)
            RectInfoRectangle(title: "Middle Trail")
                .offset(x: 189, y: 256.4)
            RectInfoRectangle(title: "Bottom Leading")
                .offset(x: 22, y: 439)
            RectInfoRectangle(title: "Bottom Trail")
                .offset(x: 189, y: 439)
        }
        .ignoresSafeArea()
    }
    
    func widget_small_320_580() -> some View {
        ZStack(alignment: .topLeading) {
            Image("widget_small_320_580")
            RectInfoRectangle(title: "Top Leading")
                .offset(x: 14, y: 30)
            RectInfoRectangle(title: "Top Trail")
                .offset(x: 165, y: 30)
            RectInfoRectangle(title: "Middle Leading")
                .offset(x: 14, y: 200)
            RectInfoRectangle(title: "Middle Trail")
                .offset(x: 165, y: 200)
        }
        .ignoresSafeArea()
    }
    
    func RectInfoRectangle(title: String) -> some View {
        Rectangle()
            .opacity(0.5)
            .frame(width: WidgetFamily.systemSmall.size.width, height: WidgetFamily.systemSmall.size.height)
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

struct WidgetSmallPositionView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetSmallPositionView()
    }
}
