//
//  SHWidgetKind.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/25.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

enum SHWidgetKind: String, Codable {
    case guide = "Guide"
    case calendar = "Calendar"
    case clock = "Clock"
    case gif = "Gif"
    case photo = "Photo"
    
    var name: String { rawValue }
    var localizedName: String { NSLocalizedString(name, comment: "")}
}
