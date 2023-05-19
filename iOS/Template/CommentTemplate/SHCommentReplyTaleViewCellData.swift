//
//  SHCommentReplyTaleViewCellData.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/14.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit

class SHCommentReplyTaleViewCellData: NSObject {
    var id: String
    var content: String
    init(id: String, content: String) {
        self.id = id
        self.content = content
    }
}
