//
//  SHGuideWidgetView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/11.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

extension SHGuideWidgetConfiguration {
    static let `default` = SHGuideWidgetConfiguration(style: .guide, theme: .guide)
}

struct SHGuideWidgetView: SHWidgetView {
    typealias Configuration = SHGuideWidgetConfiguration
    let configuration: Configuration
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            configuration.theme.background.makeView(family, colorScheme: colorScheme)
            VStack(alignment: .leading, spacing: 10) {
                let fontSize: CGFloat = getFontSize()
                Image("BrandIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .mask(RoundedRectangle(cornerRadius: 15))
                Group {
                    Text("DefaultWidget tip1")
                    Text("DefaultWidget tip2")
                    Text("DefaultWidget tip3")
                }
                .font(.system(size: fontSize, weight: .regular))
            }
            .padding(family.padding)
        }
        .foregroundColor(configuration.theme.fontColor.color)
    }
    
    func getFontSize() -> CGFloat {
        switch family {
        case .systemSmall:
            return 12
        case .systemMedium:
            return 14
        case .systemLarge:
            return 16
        case .systemExtraLarge:
            return 16
        @unknown default:
            return 16
        }
    }
}

struct GuideWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let config = SHGuideWidgetConfiguration.default
        SHGuideWidgetView(configuration: config, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        SHGuideWidgetView(configuration: config, family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        SHGuideWidgetView(configuration: config, family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
