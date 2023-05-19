//
//  SHWidgetEntry.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/8.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

protocol SHWidgetConfiguration: Codable {
    var date: Date { get }
    var style: SHWidgetStyle { get }
    var theme: SHWidgetTheme { get }
}

struct SHGuideWidgetConfiguration: SHWidgetConfiguration {
    var date: Date = Date()
    var style: SHWidgetStyle
    var theme: SHWidgetTheme
}

struct SHClockWidgetConfiguration: SHWidgetConfiguration {
    var date: Date = Date()
    var style: SHWidgetStyle
    var theme: SHWidgetTheme
}

struct SHCalendarWidgetConfiguration: SHWidgetConfiguration {
    var date: Date = Date()
    var style: SHWidgetStyle
    var theme: SHWidgetTheme
}

struct SHGifWidgetConfiguration: SHWidgetConfiguration {
    struct GifModel: Codable, Equatable {
        var imagesURL: [URL] = []
        var timeInterval: TimeInterval = 60
    }
    
    var date: Date
    var style: SHWidgetStyle
    var theme: SHWidgetTheme
    var model: GifModel
}

struct SHPhotoWidgetConfiguration: SHWidgetConfiguration {
    
    struct PhotoModel: Codable, Equatable  {
        var imagesURL: [URL] = []
        var timeInterval: TimeInterval = 60
    }
    
    var date: Date
    var style: SHWidgetStyle
    var theme: SHWidgetTheme
    var model: PhotoModel
}

extension SHWidgetEntry {
    func asGuideWidgetConfiguraiton() -> SHGuideWidgetConfiguration {
        SHGuideWidgetConfiguration(date: date, style: style, theme: theme)
    }
    
    func asCalendarWidgetConfiguraiton() -> SHCalendarWidgetConfiguration {
        SHCalendarWidgetConfiguration(date: date, style: style, theme: theme)
    }
    
    func asClockWidgetConfiguraiton() -> SHClockWidgetConfiguration {
        SHClockWidgetConfiguration(date: date, style: style, theme: theme)
    }
    
    func asGifWidgetConfiguraiton() -> SHGifWidgetConfiguration {
        SHGifWidgetConfiguration(date: date, style: style, theme: theme, model: resolvedGifModel)
    }
    
    func asPhotoWidgetConfiguration() -> SHPhotoWidgetConfiguration {
        SHPhotoWidgetConfiguration(date: date, style: style, theme: theme, model: resolvedPhotoModel)
    }
}

struct SHWidgetEntry: TimelineEntry, SHWidgetConfiguration, Codable, Identifiable {
    var id: String { "\(uuidString)#\(orderID)" }//String { "\(kind.name)#\(style)#\(theme.id)#\(orderId)" }
    var uuidString = UUID().uuidString
    var date = Date()
    var editedTime: Date = Date()
    var intentThumbnailURL: URL?
    var kind: SHWidgetKind
    var style: SHWidgetStyle
    var theme: SHWidgetTheme
    var orderID: Int = 0
            
    var gifModel: SHGifWidgetConfiguration.GifModel?
    var resolvedGifModel: SHGifWidgetConfiguration.GifModel { gifModel ?? .init() }
    var photoModel: SHPhotoWidgetConfiguration.PhotoModel?
    var resolvedPhotoModel: SHPhotoWidgetConfiguration.PhotoModel { photoModel ?? .init() }
    
    #if os(iOS)
    mutating func setTransparentBackground(lightWidgetPostionImageURLDict: [WidgetPosition: URL], darkWidgetPostionImageURLDict: [WidgetPosition: URL], postion: WidgetPosition) {
        if let lightImageURL = lightWidgetPostionImageURLDict[postion] {
            let darkImageURL = darkWidgetPostionImageURLDict[postion]
            theme.background = SHWidgetBackground(transparent: (lightImageURL: lightImageURL, darkImageURL: darkImageURL ?? lightImageURL))
        }
    }
    #endif
}

extension SHWidgetEntry {
    func intentThumbnailName(_ family: WidgetFamily) -> String {
        "intent_thumbnail#\(family)#\(id)"
    }
    func photoName(_ family: WidgetFamily) -> String {
        "photo#\(family)#\(id)"
    }
    func backgroundImageName(_ family: WidgetFamily) ->String {
        "background#\(family)#\(id)"
    }
}

extension SHWidgetEntry {
    var name: String { kind.name }
    var localizedName: String { kind.localizedName }
    var orderName: String { kind.localizedName + String(orderID) }
}

extension SHWidgetEntry {
    static let guide = SHWidgetEntry(kind: .guide, style: .guide, theme: .guide)
    static let calendar_plain = SHWidgetEntry(kind: .calendar, style: .calendar_plain, theme: .calendar_plain)
    static let clock_analog_plain = SHWidgetEntry(kind: .clock, style: .clock_analog_plain, theme: .clock_analog_plain)
    static let gif_plain = SHWidgetEntry(kind: .gif, style: .gif_plain, theme: .gif_plain)
    static let photo_plain = SHWidgetEntry(kind: .photo , style: .photo_plain, theme: .photo_plain)
    static let allItems: [SHWidgetEntry] = .allItems
}

extension Array where Element == SHWidgetEntry {
    static let calendars: [SHWidgetEntry] = [.calendar_plain]
    static let clocks: [SHWidgetEntry] = [.clock_analog_plain]
    static let photos: [SHWidgetEntry] = [.photo_plain, .gif_plain]
    static let allItems: [SHWidgetEntry] = [.calendar_plain, .clock_analog_plain, .photo_plain]
}
