//
//  AFAPIIPAction.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/29.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

struct AFAPIIPAction: AFAPIAction {
    struct SHAPIIPParameters: AFAPIParameters {
        var ip: String
    }
    typealias Parameters = SHAPIIPParameters
    typealias Response = String
    var host: String { "http://realip.cc" }
    var parameters: Parameters?
    
    init(ip: String? = nil) {
        self.parameters = ip == nil ? nil : .init(ip: ip!)
    }
}
