//
//  SHHomeNavigationItem.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/29.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation
import SwiftUI

enum SHHomeNavigationItem: CaseIterable {    
    case tool
    case feature
    case framework
    case languageInteroperability
    
    var name: String {
        switch self {
        case .tool:
            return "Tool"
        case .feature:
            return "Feature"
        case .framework:
            return "Framework"
        case .languageInteroperability:
            return "Language Interoperability"
        }
    }
}
