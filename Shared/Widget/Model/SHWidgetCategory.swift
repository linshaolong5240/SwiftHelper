//
//  SHWidgetCategory.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/10.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation
import WidgetKit

enum SHWidgetCategory: String, CaseIterable, Identifiable {
    case calendar = "Calendar"
    case clock = "Clock"
    case photo = "Photo"
    
    var id: String { rawValue }
    var name: String { rawValue }
}

extension SHWidgetCategory {
    func getWidget(family: WidgetFamily) -> [SHWidgetEntry] {
        switch self {
        case .calendar:
            return .calendars
        case .clock:
            return .clocks
        case .photo:
            return .photos
        }
    }
}
