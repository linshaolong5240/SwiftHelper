//
//  MLFeatureType+Extension.swift
//  SwiftHelper
//
//  Created by sauron on 2023/3/24.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import CoreML

extension MLFeatureType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalid:
            return "invalid"
        case .int64:
            return "int64"
        case .double:
            return "double"
        case .string:
            return "string"
        case .image:
            return "image"
        case .multiArray:
            return "multiArray"
        case .dictionary:
            return "dictionary"
        case .sequence:
            return "sequence"
        @unknown default:
            return "unknown default"
        }
    }
}

extension MLFeatureType: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .invalid:
            return "invalid: \(rawValue)"
        case .int64:
            return "int64: \(rawValue)"
        case .double:
            return "double: \(rawValue)"
        case .string:
            return "string: \(rawValue)"
        case .image:
            return "image: \(rawValue)"
        case .multiArray:
            return "multiArray: \(rawValue)"
        case .dictionary:
            return "dictionary: \(rawValue)"
        case .sequence:
            return "sequence: \(rawValue)"
        @unknown default:
            return "unknown default: \(rawValue)"
        }
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ mlFeatureType: MLFeatureType) {
        appendLiteral(mlFeatureType.description)
    }
}

extension LocalizedStringKey.StringInterpolation {
    mutating func appendInterpolation(_ mlFeatureType: MLFeatureType) {
        appendLiteral(mlFeatureType.description)
    }
}
