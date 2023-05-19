//
//  SHAPIIPAction.swift
//  SwiftHelper
//
//  Created by sauron on 2022/8/22.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

struct SHAPIIPAction: SHAPIAction {
    struct IPParameters: SHAPIParameters {
        var ip: String
    }
    typealias Parameters = IPParameters
    typealias Response = String
    var host: String { "http://realip.cc" }
    var parameters: Parameters?
    
    init(ip: String? = nil) {
        self.parameters = ip == nil ? nil : .init(ip: ip!)
    }
}
