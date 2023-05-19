//
//  SHTableSection.swift
//  SwiftHelper
//
//  Created by sauron on 2022/5/27.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

struct SHTableSection<Label, Element> {
    var label: Label?
    var items: [Element]
}

struct SHStringArraySection<Element> {
    var title: String
    var items: [Element]
}
