//
//  MLMultiArrayDataType+Extension.swift
//  SwiftHelper
//
//  Created by 林少龙 on 2023/3/24.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import CoreML

extension MLMultiArrayDataType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .double:
            return "double"
        case .float32:
            return "float32"
        case .float16:
            return "float16"
        case .int32:
            return "int32"
        @unknown default:
            return "unknown default"
        }
    }
}

extension MLMultiArrayDataType: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .double:
            return "double: \(rawValue)"
        case .float32:
            return "float32: \(rawValue)"
        case .float16:
            return "float16: \(rawValue)"
        case .int32:
            return "int32: \(rawValue)"
        @unknown default:
            return "unknown default: \(rawValue)"
        }
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ mlMultiArrayDataType: MLMultiArrayDataType) {
        appendLiteral(mlMultiArrayDataType.description)
    }
}

extension LocalizedStringKey.StringInterpolation {
    mutating func appendInterpolation(_ mlMultiArrayDataType: MLMultiArrayDataType) {
        appendLiteral(mlMultiArrayDataType.description)
    }
}
