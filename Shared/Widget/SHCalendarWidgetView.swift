//
//  SHCalendarWidgetView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/17.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

extension SHCalendarWidgetConfiguration {
    static let calendar_plain = SHCalendarWidgetConfiguration(style: .calendar_plain, theme: .calendar_plain)
}

struct SHCalendarWidgetView: SHWidgetView {
    typealias Configuration = SHCalendarWidgetConfiguration
    let configuration: Configuration
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        switch configuration.style {
        case .calendar_plain:
            widgetStyle(SHCalendarPlainWidgetStyle())
        default:
            EmptyView()
        }
    }
}

#if DEBUG
struct SHCalendarWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let config = SHCalendarWidgetConfiguration.calendar_plain
        SHCalendarWidgetView(configuration: config, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        SHCalendarWidgetView(configuration: config, family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        SHCalendarWidgetView(configuration: config, family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
#endif

struct SHCalendarPlainWidgetStyle: SHWidgetViewStyle {
    typealias Configuration = SHCalendarWidgetConfiguration
    
    func makeBody(_ configuration: SHCalendarWidgetConfiguration, family: WidgetFamily, colorScheme: ColorScheme) -> some View {
        ZStack {
            configuration.theme.background.makeView(family, colorScheme: colorScheme)
            SHCalendarMonthView(month: configuration.date, hSpacing: 4, vSpacing: 10) { date in
                ZStack {
                    if Calendar.current.isDateInToday(date) {
                        Circle()
                            .foregroundColor(configuration.theme.fontColor.color.opacity(0.3))
                    }
                    Text(String(Calendar.current.component(.day, from: date)))
                        .minimumScaleFactor(0.1)
                        .padding(4)
                }
                .frame(minWidth: 15, idealWidth: 40, maxWidth: .infinity, minHeight: 15, idealHeight: 40, maxHeight: .infinity)
            }
            .padding()
        }
        .foregroundColor(configuration.theme.fontColor.color)
    }
}
