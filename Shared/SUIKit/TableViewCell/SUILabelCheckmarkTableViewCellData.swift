//
//  SUILabelCheckmarkTableViewCellData.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/20.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit

class SUILabelCheckmarkTableViewCellData: SUITableViewCellData {
    
    var text: String
    
    var isSelect: Bool
    
    init(text: String, isSelect: Bool) {
        self.text = text
        self.isSelect = isSelect
    }
    
}


