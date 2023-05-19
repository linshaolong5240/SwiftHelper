//
//  SearchPathDomainMask+Extension.swift
//  SwiftHelper
//
//  Created by sauron on 2023/4/30.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

extension FileManager.SearchPathDomainMask: Hashable { }

extension FileManager.SearchPathDomainMask: Identifiable {
    public var id: UInt {
        rawValue
    }
}

extension FileManager.SearchPathDomainMask: CaseIterable {
    public static var allCases: [FileManager.SearchPathDomainMask] {
        [.userDomainMask, .localDomainMask, .networkDomainMask, .systemDomainMask, allDomainsMask]
    }
}

extension FileManager.SearchPathDomainMask: CustomStringConvertible {
    public var description: String {
        switch self {
        case .userDomainMask:
            return "userDomainMask"
        case .localDomainMask:
            return "localDomainMask"
        case .networkDomainMask:
            return "networkDomainMask"
        case .systemDomainMask:
            return "systemDomainMask"
        case .allDomainsMask:
            return "allDomainsMask"
        default:
            return "unknown"
        }
    }
}

extension FileManager.SearchPathDomainMask: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .userDomainMask:
            return "userDomainMask: \(rawValue)"
        case .localDomainMask:
            return "localDomainMask: \(rawValue)"
        case .networkDomainMask:
            return "networkDomainMask: \(rawValue)"
        case .systemDomainMask:
            return "systemDomainMask: \(rawValue)"
        case .allDomainsMask:
            return "allDomainsMask: \(rawValue)"
        default:
            return "unknown: \(rawValue)"
        }
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ searchPathDomainMask: FileManager.SearchPathDomainMask) {
        appendLiteral(searchPathDomainMask.description)
    }
}

extension LocalizedStringKey.StringInterpolation {
    mutating func appendInterpolation(_ searchPathDomainMask: FileManager.SearchPathDomainMask) {
        appendLiteral(searchPathDomainMask.description)
    }
}
