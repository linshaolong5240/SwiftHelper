//
//  SHWidgetPreview.swift
//  SwiftHelper
//
//  Created by sauron on 2022/4/22.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit


class SHWidgetPreviewModel: ObservableObject {
    @Published var widget: SHWidgetEntry
    let family: WidgetFamily
    
    init(widget: SHWidgetEntry, family: WidgetFamily) {
        self.widget = widget
        self.family = family
    }
}

struct SHWidgetPreview: View {
    struct WidgetResize {
        var scale: CGFloat
        var size: CGSize
    }
    
    @ObservedObject private var viewModel: SHWidgetPreviewModel
    
    let widgetResize: WidgetResize?
    
    init(entry: SHWidgetEntry, family: WidgetFamily, widgetResize: WidgetResize? = nil) {
        self.viewModel = SHWidgetPreviewModel(widget: entry, family: family)
        self.widgetResize = widgetResize
    }
    
    var body: some View {
        if let resize = widgetResize {
            SHWidgetEntryParseView(entry: viewModel.widget, family: viewModel.family)
                .modifier(WidgetPreviewModifier(family: viewModel.family))
                .scaleEffect(resize.scale)
                .frame(width: resize.size.width, height: resize.size.height)
        } else {
            SHWidgetEntryParseView(entry: viewModel.widget, family: viewModel.family)
                .modifier(WidgetPreviewModifier(family: viewModel.family))
        }
    }
}

struct WidgetPreviewDemo: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                SHWidgetPreview(entry: .clock_analog_plain, family: .systemSmall)
                WidgetSmallLayoutPreview(widgets: [.clock_analog_plain, .calendar_plain, .photo_plain])
                WidgetSmallAndMediumLayoutPreview(widgets: [.clock_analog_plain, .calendar_plain])
                WidgetLargelayoutPreview(widgets: [.clock_analog_plain, .calendar_plain])
                WidgetLargelayoutPreview(widgets: [.photo_plain])
            }
        }
    }
    
}

public struct WidgetPreviewModifier: ViewModifier {
    let family: WidgetFamily

    public func body(content: Content) -> some View {
        content
            .frame(width: family.size.width, height: family.size.height)
            .cornerRadius(family.cornerRadius)
            .shadow(radius: 10)
    }
}

struct WidgetSmallLayoutPreview: View {
    let widgets: [SHWidgetEntry]
    private let family: WidgetFamily = .systemSmall

    var body: some View {
        HStack(spacing: 14) {
            let length: CGFloat = (UIScreen.main.bounds.size.width - 60) / 3
            ForEach(widgets) { item in
                SHWidgetPreview(entry: item, family: family, widgetResize: .init(scale: length / family.size.width, size: CGSize(width: length, height: length / family.ratio)))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(.horizontal)
    }
}

struct WidgetSmallAndMediumLayoutPreview: View {
    let widgets: [SHWidgetEntry]
    
    var body: some View {
        HStack(spacing: 14) {
            let length: CGFloat = (UIScreen.main.bounds.size.width - 60) / 3
            SHWidgetPreview(entry: widgets[0], family: .systemSmall, widgetResize: .init(scale: length / WidgetFamily.systemSmall.size.width, size: CGSize(width: length, height: length / WidgetFamily.systemSmall.ratio)))
            SHWidgetPreview(entry: widgets[1], family: .systemMedium, widgetResize: .init(scale: length / WidgetFamily.systemSmall.size.height, size: CGSize(width: length * WidgetFamily.systemMedium.ratio, height: length)))
        }
        .padding(.horizontal)
    }
}

struct WidgetLargelayoutPreview: View {
    let widgets: [SHWidgetEntry]
    private let family: WidgetFamily = .systemLarge

    var body: some View {
        HStack {
            let length: CGFloat = (UIScreen.main.bounds.size.width - 16 - 14 - 16) / 2
            if widgets.count % 2 == 0 {
                ForEach(widgets) { item in
                    SHWidgetPreview(entry: item, family: family, widgetResize: .init(scale: length / family.size.width, size: CGSize(width: length, height: length / family.ratio)))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } else {
                SHWidgetPreview(entry: widgets[0], family: family, widgetResize: .init(scale: length / family.size.width, size: CGSize(width: length, height: length / family.ratio)))
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct SHWidgetPreview_Previews: PreviewProvider {
    static var previews: some View {
        WidgetPreviewDemo()
    }
}
#endif
