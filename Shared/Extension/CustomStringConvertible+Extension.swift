//
//  CustomStringConvertible+Extension.swift
//  SwiftHelper
//
//  Created by sauron on 2022/8/20.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

extension CustomStringConvertible {
    public var reflectingDescription: String {
        let mirror = Mirror(reflecting: self)
        
        var str = "\(mirror.subjectType)("
        var first = true
        for (label, value) in mirror.children {
          if let label = label {
            if first {
              first = false
            } else {
              str += ", "
            }
            str += label
            str += ": "
            str += "\(value)"
          }
        }
        str += ")"
        
        return str
      }
}
