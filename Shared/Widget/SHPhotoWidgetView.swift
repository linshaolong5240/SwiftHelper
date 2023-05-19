//
//  SHPhotoWidgetView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/25.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

struct SHPhotoWidgetView: SHWidgetView {
    typealias Configuration = SHPhotoWidgetConfiguration
    let configuration: Configuration
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        widgetStyle(SHPlainPhotoWidgetStyle())
    }
}

#if DEBUG
struct SHPhotoWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let entry: SHWidgetEntry = .photo_plain
        SHWidgetEntryParseView(entry: entry, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        SHWidgetEntryParseView(entry: entry, family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        SHWidgetEntryParseView(entry: entry, family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
#endif

struct SHPlainPhotoWidgetStyle: SHWidgetViewStyle {
    typealias Configuration = SHPhotoWidgetConfiguration

    func makeBody(_ configuration: Configuration, family: WidgetFamily, colorScheme: ColorScheme) -> some View {
        ZStack {
            if !configuration.model.imagesURL.isEmpty {
                let index = Int(configuration.date.timeIntervalSince1970) % configuration.model.imagesURL.count
                ZStack {
                    if let image = configuration.model.imagesURL[index].image {
                        Image(crossImage: image)
                            .resizable()
                    }
                    Text("\(configuration.date)")
                }
            } else {
                Image(family == .systemMedium ? "PhotoWidgetDefaultBackgroundImage2" : "PhotoWidgetDefaultBackgroundImage1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}
