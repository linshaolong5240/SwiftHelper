//
//  NWInterface_InterfaceType+Extension.swift
//  SwiftHelper
//
//  Created by sauron  on 2023/4/10.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import Network

extension NWInterface.InterfaceType: CaseIterable, CustomStringConvertible {
    
    public static var allCases: [NWInterface.InterfaceType] = [.other, .wifi, .cellular, .wiredEthernet, .loopback]
    
    public var description: String {
        switch self {
        case .other:
            return "other"
        case .wifi:
            return "wifi"
        case .cellular:
            return "cellular"
        case .wiredEthernet:
            return "wiredEthernet"
        case .loopback:
            return "loopback"
        @unknown default:
            return "unknown default"
        }
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ interfaceType: NWInterface.InterfaceType) {
        appendLiteral(interfaceType.description)
    }
}

extension LocalizedStringKey.StringInterpolation {
    mutating func appendInterpolation(_ interfaceType: NWInterface.InterfaceType) {
        appendLiteral(interfaceType.description)
    }
}
