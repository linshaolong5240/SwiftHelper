//
//  SHWidgetTheme+Extension.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/4/30.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

extension SHWidgetBackground {
    @ViewBuilder func makeView(_ family: WidgetFamily, colorScheme: ColorScheme) -> some View {
        switch type {
        case .color(let wrapperColor):
            wrapperColor.color
        case .colors(let wrapperColors):
            LinearGradient(colors: wrapperColors.map(\.color), startPoint: .topLeading, endPoint: .bottomTrailing)
        case .imageName(let name):
            Image(name).resizable()
        case .imageNameFamily(let small, let medium, let large):
            switch family {
            case .systemSmall: Image(small).resizable()
            case .systemMedium: Image(medium).resizable()
            case .systemLarge: Image(large).resizable()
            default: EmptyView()
            }
        case .imageURL(let url):
            if let crossImage = CrossImage(contentsOfFile: url.path) {
                Image(crossImage: crossImage).resizable()
            }else {
                EmptyView()
            }
        #if os(iOS)
        case .transparent(let lightImageURL, let darkImageURL):
            switch colorScheme {
            case .light:
                if let crossImage = CrossImage(contentsOfFile: lightImageURL.path) {
                    Image(crossImage: crossImage).resizable().aspectRatio(contentMode: .fit)
                } else {
                    EmptyView()
                }
            case .dark:
                if let crossImage = CrossImage(contentsOfFile: darkImageURL.path) {
                    Image(crossImage: crossImage).resizable().aspectRatio(contentMode: .fit)
                } else {
                    EmptyView()
                }
            default:
                EmptyView()
            }
        #endif
        }
    }
}
