//
//  SwiftHelperWidget.swift
//  SwiftHelperWidget
//
//  Created by sauron on 2022/3/7.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct MainWidgets: WidgetBundle {
    init() {
    }
    
    @WidgetBundleBuilder
    var body: some Widget {
        SmallWidget()
        MediumWidget()
        LargeWidget()
    }
}

struct WidgetDataSource {
    @CombineUserStorge(key: .widgetTransparentConfiguration, container: .group)
    static var transparentConfiguration: SHWidgetTransparentConfiguration = SHWidgetTransparentConfiguration()
    @CombineUserStorge(key: .smallWidgetConfiguration, container: .group)
    static var smallWidgetConfiguration: [SHWidgetEntry] = []
    @CombineUserStorge(key: .mediumWidgetConfiguration, container: .group)
    static var mediumWidgetConfiguration: [SHWidgetEntry] = []
    @CombineUserStorge(key: .largeWidgetConfiguration, container: .group)
    static var largeWidgetConfiguration: [SHWidgetEntry] = []
}

extension IntentTimelineProvider where Entry == SHWidgetEntry {
    
    func widgetPlaceholder(in context: Context) -> SHWidgetEntry {
        .guide
    }
    
    func getWidgetSnapshot<Intent>(for configuration: Intent, in context: Context, completion: @escaping (SHWidgetEntry) -> ()) where Intent: WidgetIntent {
        completion(.guide)
    }
    
    func getWidgetTimeline<Intent>(for configuration: Intent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) where Intent: WidgetIntent {
        
        func setTransparentBackground(widgetConfiguration: inout SHWidgetEntry) {
            if let identifier = configuration.transparentBackground?.identifier, let rawValue = Int(identifier), let widgetPosition = WidgetPosition(rawValue: rawValue) {
                widgetConfiguration.setTransparentBackground(lightWidgetPostionImageURLDict: WidgetDataSource.transparentConfiguration.lightWidgetPostionImageURLDict, darkWidgetPostionImageURLDict: WidgetDataSource.transparentConfiguration.darkWidgetPostionImageURLDict, postion: widgetPosition)
            }
        }
        
        var widgetEntries = [SHWidgetEntry]()
        switch context.family {
        case .systemSmall:
            widgetEntries = WidgetDataSource.smallWidgetConfiguration
        case .systemMedium:
            widgetEntries = WidgetDataSource.mediumWidgetConfiguration
        case .systemLarge:
            widgetEntries = WidgetDataSource.largeWidgetConfiguration
        default: break
        }
        
        guard let widgetIdentifier = configuration.currentWidget?.identifier, var widgetEntry = widgetEntries.first(where: { $0.id == widgetIdentifier }) else {
            var widgetConfiguration: SHWidgetEntry = .guide
            setTransparentBackground(widgetConfiguration: &widgetConfiguration)
            let entries: [SHWidgetEntry] = [widgetConfiguration]
            let timeline = Timeline(entries: entries, policy: .never)
            completion(timeline)
            return
        }
        
        setTransparentBackground(widgetConfiguration: &widgetEntry)
        
        switch widgetEntry.kind {
        case .guide:
            getStaticTimeline(for: widgetEntry, in: context, completion: completion)
        case .clock:
            getMinutesTimeline(for: widgetEntry, in: context, completion: completion)
        case .calendar:
            getNextDayTimeline(for: widgetEntry, in: context, completion: completion)
        case .gif:
            getGifTimeline(for: widgetEntry, in: context, completion: completion)
        case .photo:
            getPhotoTimeline(for: widgetEntry, in: context, completion: completion)
//        case .clock_analog:
//            getMinutesTimeline(for: widgetType, in: context, completion: completion)
//        case .clock_digital:
//            getMinutesTimeline(for: widgetType, in: context, completion: completion)
//        case .countdown_days:
//            getNextDayTimeline(for: widgetType, in: context, completion: completion)
//        case .notepad:
//            getStaticTimeline(for: widgetType, in: context, completion: completion)
//        case .shortcut:
//            getStaticTimeline(for: widgetType, in: context, completion: completion)
//        case .weather:
//            getWeatherTimeline(for: widgetType, in: context, completion: completion)
        }
        
    }
    
    func getStaticTimeline(for widgetEntry: SHWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SHWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        var entry = widgetEntry
        entry.date = Date()
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
    
    func getMinutesTimeline(for widgetEntry: SHWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SHWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let now = Date()
        var minutes = [Date]()
        var interval = DateInterval()
        interval = Calendar.current.dateInterval(of: .hour, for: now)!
        interval.start = now
        minutes.append(interval.start)
        let dates = Calendar.current.generateDates(inside: interval, matching: DateComponents(second: 0))
        minutes.append(contentsOf: dates)
        entries = minutes[..<29].map({ date in
            var entry = widgetEntry
            entry.date = date
            return entry
        })
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func getNextDayTimeline(for widgetEntry: SHWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SHWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let now = Date()
        var entry = widgetEntry
        entry.date = now
        entries.append(entry)
        let refleshDate: Date = Calendar.current.nextDay(for: now)
        
        let timeline = Timeline(entries: entries, policy: .after(refleshDate))
        completion(timeline)
    }
    
    func getCountdownDayTimeline(for widgetEntry: SHWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SHWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let now = Date() + 2
        var minutes = [Date]()
        var interval = DateInterval()
        interval = Calendar.current.dateInterval(of: .hour, for: now)!
        interval.start = now
        minutes.append(interval.start)
        Calendar.current.enumerateDates(startingAfter: interval.start, matching: DateComponents(second: 0), matchingPolicy: .nextTime) { date, strict, stop in
            if let date = date {
                if date < interval.end {
                    minutes.append(date)
                }else {
                    stop = true
                }
            }
        }
        entries = minutes.map({ date in
            var entry = widgetEntry
            entry.date = date
            return entry
        })
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func getGifTimeline(for widgetEntry: SHWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SHWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let now = Date()
        let refreshDate = now + 60 * 5 + 2

        for secondOffset in 0 ..< 60 * 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: now)!
            var entry = widgetEntry
            entry.date = entryDate
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
    
    func getPhotoTimeline(for widgetEntry: SHWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SHWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let now = Date()
        let refreshDate = now + 60 * 5
        //limit size 260 * 100Kb
        for secondOffset in 0 ..< 300 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: now)!
            var entry = widgetEntry
            entry.date = entryDate
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
    
//    func getWeatherTimeline(for widget: SHWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//
//        var entries: [SHWidgetEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let now = Date()
//        let requestFailedDate = now + 5 * 60
//        let refreshDate = Calendar.current.nextHour(for: now)
//
//        var entry = widget
//        entry.date = now
//
//        guard let location = entry.weatherData?.location else {
//            entries.append(entry)
//            let timeline = Timeline(entries: entries, policy: .after(refreshDate))
//            completion(timeline)
//            return
//        }
//
//        CW.request(action: CWApiWeatherAction(location)) { result in
//            switch result {
//            case .success(let response):
//                guard let data = response?.data else {
//                    entries.append(entry)
//                    let timeline = Timeline(entries: entries, policy: .after(requestFailedDate))
//                    completion(timeline)
//                    return
//                }
//                entry.weatherData?.weather = data
//                switch context.family {
//                case .systemSmall:
//                    if let index = savedSmallWidgets.firstIndex(where: { $0.id == entry.id }) {
//                        savedSmallWidgets[index] = entry
//                    }
//                case .systemMedium:
//                    if let index =  savedMediumWidgets.firstIndex(where: { $0.id == entry.id }) {
//                        savedMediumWidgets[index] = entry
//                    }
//                case .systemLarge:
//                    if let index =  savedLargeWidgets.firstIndex(where: { $0.id == entry.id }) {
//                        savedLargeWidgets[index] = entry
//                    }
//                case .systemExtraLarge:
//                    break
//                @unknown default:
//                    break
//                }
//                entries.append(entry)
//                let timeline = Timeline(entries: entries, policy: .after(refreshDate))
//                completion(timeline)
//            case .failure(let error):
//                #if DEBUG
//                print(error)
//                #endif
//                entries.append(entry)
//                let timeline = Timeline(entries: entries, policy: .after(requestFailedDate))
//                completion(timeline)
//            }
//        }
//    }
    
}

struct CWWidgetSmallProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> SHWidgetEntry {
        widgetPlaceholder(in: context)
    }

    func getSnapshot(for configuration: WidgetSmallConfigurationIntent, in context: Context, completion: @escaping (SHWidgetEntry) -> ()) {
        getWidgetSnapshot(for: configuration, in: context, completion: completion)
    }

    func getTimeline(for configuration: WidgetSmallConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getWidgetTimeline(for: configuration, in: context, completion: completion)
    }
}

struct CWWidgetMediumProvider: IntentTimelineProvider {

    func placeholder(in context: Context) -> SHWidgetEntry {
        widgetPlaceholder(in: context)
    }

    func getSnapshot(for configuration: WidgetMediumConfigurationIntent, in context: Context, completion: @escaping (SHWidgetEntry) -> ()) {
        getWidgetSnapshot(for: configuration, in: context, completion: completion)
    }

    func getTimeline(for configuration: WidgetMediumConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getWidgetTimeline(for: configuration, in: context, completion: completion)
    }
}

struct CWWidgetLargeProvider: IntentTimelineProvider {

    func placeholder(in context: Context) -> SHWidgetEntry {
        widgetPlaceholder(in: context)
    }

    func getSnapshot(for configuration: WidgetLargeConfigurationIntent, in context: Context, completion: @escaping (SHWidgetEntry) -> ()) {
        getWidgetSnapshot(for: configuration, in: context, completion: completion)
    }

    func getTimeline(for configuration: WidgetLargeConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getWidgetTimeline(for: configuration, in: context, completion: completion)
    }
}


struct SHWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: SHWidgetEntry

    var body: some View {
        SHWidgetEntryParseView(entry: entry, family: family)
    }
}

struct SmallWidget: Widget {
    let kind: String = SwiftHelperWidgetKind.small.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: WidgetSmallConfigurationIntent.self, provider: CWWidgetSmallProvider()) { entry in
            SHWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("WidgetSmallDisplayName")
        .description("WidgetSmallDescription")
    }
}

struct MediumWidget: Widget {
    let kind: String = SwiftHelperWidgetKind.medium.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: WidgetMediumConfigurationIntent.self, provider: CWWidgetMediumProvider()) { entry in
            SHWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("WidgetMediumDisplayName")
        .description("WidgetMediumDescription")
    }
}

struct LargeWidget: Widget {
    let kind: String = SwiftHelperWidgetKind.large.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: WidgetLargeConfigurationIntent.self, provider: CWWidgetLargeProvider()) { entry in
            SHWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemLarge])
        .configurationDisplayName("WidgetLargeDisplayName")
        .description("WidgetLargeDescription")
    }
}

#if DEBUG
struct CoolWidgetWidget_Previews: PreviewProvider {
    static var previews: some View {
        let config = SHWidgetEntry.calendar_plain
        SHWidgetEntryView(entry: config)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        SHWidgetEntryView(entry: config)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        SHWidgetEntryView(entry: config)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
#endif
