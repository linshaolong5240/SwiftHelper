//
//  DEBUGHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2022/6/21.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

public func debugLog(_ message: Any? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
        if let message = message {
            debugPrint("🖨\((file as String).lastPathComponent):\(function):\(line) ->🧾 \(message)")
        } else {
            debugPrint("🖨\((file as String).lastPathComponent):\(function):\(line)")
        }
    #endif
}
extension String {
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }

    func appendingPathComponent(_ string: String) -> String {
        return fileURL.appendingPathComponent(string).path
    }

    var lastPathComponent: String {
        get {
            return fileURL.lastPathComponent
        }
    }

   var deletingPathExtension: String {
    return fileURL.deletingPathExtension().path
   }
}
