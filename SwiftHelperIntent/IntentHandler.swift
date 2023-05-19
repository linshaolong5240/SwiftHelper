//
//  IntentHandler.swift
//  SwiftHelperIntent
//
//  Created by sauron on 2022/3/8.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Intents
import UIKit
import WidgetKit

extension WidgetPosition {
    var imageName: String {
        switch self {
        case .smallTopLeft:
            return "icon_widget_position_small_top_left"
        case .smallTopRight:
            return "icon_widget_position_small_top_right"
        case .smallMiddleLeft:
            return "icon_widget_position_small_middle_left"
        case .smallMiddleRight:
            return "icon_widget_position_small_middle_right"
        case .smallBottomLeft:
            return "icon_widget_position_small_bottom_left"
        case .smallBottomRight:
            return "icon_widget_position_small_bottom_right"
        case .mediumTop:
            return "icon_widget_position_medium_top"
        case .mediumMiddle:
            return "icon_widget_position_medium_middle"
        case .mediumBottom:
            return "icon_widget_position_medium_bottom"
        case .largeTop:
            return "icon_widget_position_large_top"
        case .largeBottom:
            return "icon_widget_position_large_bottom"
        }
    }
}

extension IntentHandler: WidgetSmallConfigurationIntentHandling {
    func provideCurrentWidgetOptionsCollection(for intent: WidgetSmallConfigurationIntent, with completion: @escaping (INObjectCollection<WidgetType>?, Error?) -> Void) {
        provideWidgetOptionsCollection(.systemSmall, for: intent, with: completion)
    }
    
    func provideTransparentBackgroundOptionsCollection(for intent: WidgetSmallConfigurationIntent, with completion: @escaping (INObjectCollection<WidgetPositionType>?, Error?) -> Void) {
        provideTransparentBackgroundOptionsCollection(family: .systemSmall, for: intent, with: completion)
    }
}

extension IntentHandler: WidgetMediumConfigurationIntentHandling {
    func provideCurrentWidgetOptionsCollection(for intent: WidgetMediumConfigurationIntent, with completion: @escaping (INObjectCollection<WidgetType>?, Error?) -> Void) {
        provideWidgetOptionsCollection(.systemMedium, for: intent, with: completion)
    }
    
    func provideTransparentBackgroundOptionsCollection(for intent: WidgetMediumConfigurationIntent, with completion: @escaping (INObjectCollection<WidgetPositionType>?, Error?) -> Void) {
        provideTransparentBackgroundOptionsCollection(family: .systemMedium, for: intent, with: completion)
    }
}

extension IntentHandler: WidgetLargeConfigurationIntentHandling {
    func provideCurrentWidgetOptionsCollection(for intent: WidgetLargeConfigurationIntent, with completion: @escaping (INObjectCollection<WidgetType>?, Error?) -> Void) {
        provideWidgetOptionsCollection(.systemLarge, for: intent, with: completion)
    }
    
    func provideTransparentBackgroundOptionsCollection(for intent: WidgetLargeConfigurationIntent, with completion: @escaping (INObjectCollection<WidgetPositionType>?, Error?) -> Void) {
        provideTransparentBackgroundOptionsCollection(family: .systemLarge, for: intent, with: completion)
    }
}

extension IntentHandler {
    func provideWidgetOptionsCollection<Intent>(_ family: WidgetFamily, for intent: Intent, with completion: @escaping (INObjectCollection<WidgetType>?, Error?) -> Void) where Intent: WidgetIntent {
        @CombineUserStorge(key: .smallWidgetConfiguration, container: .group)
        var smallWidgetConfiguration: [SHWidgetEntry] = []
        @CombineUserStorge(key: .mediumWidgetConfiguration, container: .group)
        var mediumWidgetConfiguration: [SHWidgetEntry] = []
        @CombineUserStorge(key: .largeWidgetConfiguration, container: .group)
        var largeWidgetConfiguration: [SHWidgetEntry] = []
        
        var configurations = [SHWidgetEntry]()
        switch family {
        case .systemSmall:
            configurations = smallWidgetConfiguration
        case .systemMedium:
            configurations = mediumWidgetConfiguration
        case .systemLarge:
            configurations = largeWidgetConfiguration
        case .systemExtraLarge:
            break
        @unknown default:
            break
        }
        
        let items = configurations.map { item -> WidgetType in
            var image: INImage?
            if let url = item.intentThumbnailURL {
                if let data = UIImage(contentsOfFile: url.path)?.jpegData(compressionQuality: 0.6) {
                    image = .init(imageData: data)
                }
            }
            return WidgetType(identifier: item.id, display: item.orderName, subtitle: nil, image: image)
        }
        
        completion(INObjectCollection(sections: [INObjectSection(title: "Current Widget", items: items)]),
                   nil)
    }
    
    func provideTransparentBackgroundOptionsCollection<Intent>(family: WidgetFamily, for intent: Intent, with completion: @escaping (INObjectCollection<WidgetPositionType>?, Error?) -> Void) where Intent: WidgetIntent {
        var positionItems: [WidgetPosition] = []
        switch family {
        case .systemSmall:
            positionItems = WidgetPosition.smallItems
        case .systemMedium:
            positionItems = WidgetPosition.mediumItems
        case .systemLarge:
            positionItems = WidgetPosition.largeItems
        default:
            break
        }
        var items = positionItems.map { item -> WidgetPositionType in
            var image: INImage?
            if  let data = UIImage(named: item.imageName)?.pngData() {
                image = .init(imageData: data)
            }
            
            return WidgetPositionType(identifier: "\(item.rawValue)", display: NSLocalizedString(item.name, comment: ""), pronunciationHint: nil, subtitle: nil, image: image)
        }
        let image = INImage(imageData: UIImage(systemName: "iphone")!.pngData()!)
        let defaultType = WidgetPositionType(identifier: "\(WidgetPosition.allCases.count)", display: "None", pronunciationHint: nil, subtitle: nil, image: image)
        items.insert(defaultType, at: 0)
        completion(INObjectCollection(sections: [INObjectSection(title: nil, items: items)]), nil)
    }
}

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
