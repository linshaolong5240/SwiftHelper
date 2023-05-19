//
//  CGLineCap+Extension.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/14.
//

import SwiftUI
import enum CoreGraphics.CGPath.CGLineCap

extension CGLineCap: CaseIterable {
    public static var allCases: [CGLineCap] { [.butt, .round, .square] }
}

extension CGLineCap: CustomStringConvertible {
    public var description: String {
        switch self {
        case .butt:
            return "CGLineCap.butt"
        case .round:
            return "CGLineCap.round"
        case .square:
            return "CGLineCap.square"
        @unknown default:
            return "CGLineCap.unknown"
        }
    }
}

extension CGLineCap: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .butt:
            return "CGLineJoin.butt: \(rawValue)"
        case .round:
            return "CGLineJoin.round: \(rawValue)"
        case .square:
            return "CGLineJoin.square: \(rawValue)"
        @unknown default:
            return "CGLineJoin.unknown"
        }
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ lineCap: CGLineCap) {
        appendLiteral(lineCap.description)
    }
}

extension LocalizedStringKey.StringInterpolation {
    mutating func appendInterpolation(_ lineCap: CGLineCap) {
        appendLiteral(lineCap.description)
    }
}
