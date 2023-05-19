//
//  SHWidgetEntryParseView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/8.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

struct SHWidgetEntryParseView: View {
    let entry: SHWidgetEntry
    let family: WidgetFamily
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            entry.theme.background.makeView(family, colorScheme: colorScheme)
            switch entry.kind {
            case .guide:
                SHGuideWidgetView(configuration: entry.asGuideWidgetConfiguraiton(), family: family)
            case .calendar:
                SHCalendarWidgetView(configuration: entry.asCalendarWidgetConfiguraiton(), family: family)
            case .clock:
                SHClockWidgetView(configuration: entry.asClockWidgetConfiguraiton(), family: family)
            case .gif:
                SHGifWidgetView(configuration: entry.asGifWidgetConfiguraiton(), family: family)
            case .photo:
                SHPhotoWidgetView(configuration: entry.asPhotoWidgetConfiguration(), family: family)
            }
            entry.theme.boarder?.makeView(family: family)
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SHWidgetEntryParseView(entry: .guide, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        SHWidgetEntryParseView(entry: .guide, family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        SHWidgetEntryParseView(entry: .guide, family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
