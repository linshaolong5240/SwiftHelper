//
//  SHCommentTableViewCellData.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/14.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit

class SHCommentTableViewCellData {
    var id: String
    var content: String
    var replys:[SHCommentReplyTaleViewCellData]
    
    init(id: String, content: String, replys: [SHCommentReplyTaleViewCellData]) {
        self.id = id
        self.content = content
        self.replys = replys
    }
}
