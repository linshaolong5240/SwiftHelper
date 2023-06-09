//
//  SHClockWidgetView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/7.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

extension SHClockWidgetConfiguration {
    static let analog_plain = SHClockWidgetConfiguration(style: .clock_analog_plain, theme: .clock_analog_plain)
}

struct SHClockWidgetView: SHWidgetView {
    typealias Configuration = SHClockWidgetConfiguration
    let configuration: Configuration
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        switch configuration.style {
        case .clock_analog_plain:
            widgetStyle(SHAnalogPlainClockWidgetStyle())
        default:
            EmptyView()
        }
    }
}

#if DEBUG
struct SHClockWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let config = SHClockWidgetConfiguration.analog_plain
        SHClockWidgetView(configuration: config, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        SHClockWidgetView(configuration: config, family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        SHClockWidgetView(configuration: config, family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
#endif

struct SHAnalogPlainClockWidgetStyle: SHWidgetViewStyle {
    typealias Configuration = SHClockWidgetConfiguration
    
    func makeBody(_ configuration: SHClockWidgetConfiguration, family: WidgetFamily, colorScheme: ColorScheme) -> some View {
        GeometryReader { geometry in
            let length: CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack {
                configuration.theme.background.makeView(family, colorScheme: colorScheme)
                ZStack {
                    ClockMarkView(12, origin: false) { index in
                        Rectangle().frame(width: 2, height: 5)
                    }
                    ClockMarkView(4, origin: true) { index in
                        let hours = [12,3,6,9]
                        Text("\(hours[index])")
                            .font(.system(size: 12, weight: .bold))
                    }
                    .padding()
                    ClockNeedleView(configuration.date, for: .minute) {
                        Rectangle()
                            .frame(width: length / 100, height: length * 0.3)
                    }
                    ClockNeedleView(configuration.date, for: .hour) {
                        Rectangle()
                            .frame(width: length / 80, height: length * 0.2)
                    }
                    Circle().frame(width: length / 50, height: length / 50)
                }
                .padding()
                .frame(width: length, height: length, alignment: .center)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
        .foregroundColor(configuration.theme.fontColor.color)
    }
}
