//
//  SHWidgetTheme.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/8.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

struct SHWidgetBackground: Codable, Hashable, Equatable {
    enum BackgroundType: Codable, Hashable {
        case color(SHColorWrapper)
        case colors([SHColorWrapper])
        case imageName(String)
        case imageNameFamily(small: String, medium: String, large: String)
        case imageURL(URL)
        #if os(iOS)
        case transparent(lightImageURL: URL, darkImageURL: URL)
        #endif
    }
    
    let type: BackgroundType
    
    init(_ type: BackgroundType) {
        self.type = type
    }
    
    init(_ color: Color) {
        self.type = .color(color.colorWrapper)
    }
    
    init(_ colors: [Color]) {
        self.type = .colors(colors.map(\.colorWrapper))
    }
    
    init(imageName: String) {
        self.type = .imageName(imageName)
    }
    
    init(imageURL: URL) {
        self.type = .imageURL(imageURL)
    }
    
    init(small: String, medium: String, large: String) {
        self.type = .imageNameFamily(small: small, medium: medium, large: large)
    }
    
    #if os(iOS)
    init(transparent: (lightImageURL: URL, darkImageURL: URL)) {
        self.type = .transparent(lightImageURL: transparent.lightImageURL, darkImageURL: transparent.darkImageURL)
    }
    #endif
    
    var imageURL: URL? {
        switch type {
        case .imageURL(let url):
            return url
        #if os(iOS)
        case .transparent(let lightImageURL, _):
            return lightImageURL
        #endif
        default:
            return nil
        }
    }
}

struct SHWidgetBorder: Codable, Hashable, Equatable {
    enum CWWidgetBorderType: Codable, Hashable, Equatable {
        case color(SHColorWrapper)
        case colors([SHColorWrapper])
        case image(String)
    }
    
    let type: CWWidgetBorderType
    
    init(_ type: CWWidgetBorderType) {
        self.type = type
    }
    
    init(_ color: Color) {
        self.type = .color(color.colorWrapper)
    }
    
    init(_ colors: [Color]) {
        self.type = .colors(colors.map(\.colorWrapper))
    }
    
    init(imageName: String) {
        self.type = .image(imageName)
    }
    
    @ViewBuilder func makeView(family: WidgetFamily? = nil) -> some View {
        Group {
            switch type {
            case .color(let colorWrapper):
                colorWrapper.color
            case .colors(let colorWrappers):
                LinearGradient(gradient: .init(colors: colorWrappers.map(\.color)), startPoint: .topLeading, endPoint: .bottomTrailing)
            case .image(let imageName):
                Image(imageName)
            }
        }
        .mask(RoundedRectangle(cornerRadius: family?.cornerRadius ?? CGFloat(10)).strokeBorder(Color.black, lineWidth: family == nil ? 5 : 15))
    }
}

struct SHWidgetColorScheme: Codable, Hashable, Equatable {
    var color0: SHColorWrapper
    var color1: SHColorWrapper
    var color2: SHColorWrapper
    var color3: SHColorWrapper
    
    init() {
        self.init(.black)
    }
    
    init(_ colors: Color...) {
        switch colors.count {
        case 0:
            self.color0 = Color.black.colorWrapper
            self.color1 = Color.black.colorWrapper
            self.color2 = Color.black.colorWrapper
            self.color3 = Color.black.colorWrapper
        case 1:
            self.color0 = colors[0].colorWrapper
            self.color1 = colors[0].colorWrapper
            self.color2 = colors[0].colorWrapper
            self.color3 = colors[0].colorWrapper
        case 2:
            self.color0 = colors[0].colorWrapper
            self.color1 = colors[1].colorWrapper
            self.color2 = colors[1].colorWrapper
            self.color3 = colors[1].colorWrapper
        case 3:
            self.color0 = colors[0].colorWrapper
            self.color1 = colors[1].colorWrapper
            self.color2 = colors[2].colorWrapper
            self.color3 = colors[2].colorWrapper
        default:
            self.color0 = colors[0].colorWrapper
            self.color1 = colors[1].colorWrapper
            self.color2 = colors[2].colorWrapper
            self.color3 = colors[3].colorWrapper
        }
    }
}

typealias SHWidgetColor = SHColorWrapper

struct SHWidgetTheme: Codable, Identifiable, Equatable {
    var id: Int = 0
    var colorScheme: SHWidgetColorScheme? = nil
    var font: SHFontWrapper? = nil
    var fontColor: SHColorWrapper
    var background: SHWidgetBackground
    var boarder: SHWidgetBorder? = nil
}

extension SHWidgetTheme {
    static let guide = SHWidgetTheme(fontColor: .init(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))), background: .init(Color(#colorLiteral(red: 0.9423639178, green: 0.3159325123, blue: 0.2204112411, alpha: 1))))
    static let calendar_plain = SHWidgetTheme(fontColor: .init(Color(#colorLiteral(red: 0.9423639178, green: 0.3159325123, blue: 0.2204112411, alpha: 1))), background: .init(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))))
    static let clock_analog_plain = SHWidgetTheme(fontColor: .init(Color(#colorLiteral(red: 0.9423639178, green: 0.3159325123, blue: 0.2204112411, alpha: 1))), background: .init(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))))
    static let gif_plain = SHWidgetTheme(fontColor: .init(Color(#colorLiteral(red: 0.9423639178, green: 0.3159325123, blue: 0.2204112411, alpha: 1))), background: .init(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))))
    static let photo_plain = SHWidgetTheme(fontColor: .init(Color(#colorLiteral(red: 0.9423639178, green: 0.3159325123, blue: 0.2204112411, alpha: 1))), background: .init(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))))
}
