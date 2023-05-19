//
//  CGLineJoin+Extension.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/15.
//

import SwiftUI
import CoreGraphics

extension CGLineJoin: CaseIterable {
    public static var allCases: [CGLineJoin] { [.miter, .round, .bevel] }
}

extension CGLineJoin: CustomStringConvertible {
    public var description: String {
        switch self {
        case .miter:
            return "CGLineJoin.miter"
        case .round:
            return "CGLineJoin.round"
        case .bevel:
            return "CGLineJoin.bevel"
        @unknown default:
            return "CGLineJoin.unknown"
        }
    }
}

extension CGLineJoin: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .miter:
            return "CGLineJoin.miter: \(rawValue)"
        case .round:
            return "CGLineJoin.round: \(rawValue)"
        case .bevel:
            return "CGLineJoin.bevel: \(rawValue)"
        @unknown default:
            return "CGLineJoin.unknown"
        }
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ lineJoin: CGLineJoin) {
        appendLiteral(lineJoin.description)
    }
}

extension LocalizedStringKey.StringInterpolation {
    mutating func appendInterpolation(_ lineJoin: CGLineJoin) {
        appendLiteral(lineJoin.description)
    }
}
