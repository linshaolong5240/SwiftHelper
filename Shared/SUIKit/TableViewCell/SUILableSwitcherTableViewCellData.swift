//
//  SUILableSwitcherTableViewCellData.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/19.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit

class SUILableSwitcherTableViewCellData: SUITableViewCellData {
    
    var text: String
    
    var isOn: Bool

    init(text: String, isOn: Bool, selector: Selector? = nil) {
        self.text = text
        self.isOn = isOn
        super.init(selector: selector)
    }
    
}
