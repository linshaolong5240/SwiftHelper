//
//  AppAction.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/14.
//

import Foundation
import SwiftUI
import WidgetKit

enum AppAction {
    case initAction
    case error(AppError)
    
    #if os(iOS)
    //Widget
    case saveWidget(configuration: SHWidgetEntry, family: WidgetFamily)
    case updateWidget(configuration: SHWidgetEntry, family: WidgetFamily)
    case deleteWidget(configuration: SHWidgetEntry, family: WidgetFamily)
    case reloadWidget(kind: String? = nil)
    case setWidgetPostionImageDict(dict: [WidgetPosition : URL], colorScheme: ColorScheme)
    case setWidgetTransparentBackground(imageURL: URL, colorScheme: ColorScheme)
    #endif
}
