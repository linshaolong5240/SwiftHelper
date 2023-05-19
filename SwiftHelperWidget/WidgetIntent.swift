//
//  WidgetIntent.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/10.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

protocol WidgetIntent {
    var currentWidget: WidgetType? { get }
    var transparentBackground: WidgetPositionType? { get }
}
extension WidgetSmallConfigurationIntent: WidgetIntent { }
extension WidgetMediumConfigurationIntent: WidgetIntent { }
extension WidgetLargeConfigurationIntent: WidgetIntent { }
