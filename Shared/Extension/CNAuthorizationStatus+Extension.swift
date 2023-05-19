//
//  CNAuthorizationStatus+Extension.swift
//  SwiftHelper
//
//  Created by sauron on 2022/12/24.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import SwiftUI
import enum Contacts.CNContactStore.CNAuthorizationStatus

extension CNAuthorizationStatus: CaseIterable {
    public static var allCases: [CNAuthorizationStatus] { [.notDetermined, .restricted, .denied, .authorized] }
}

extension CNAuthorizationStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .notDetermined:
            return "CNAuthorizationStatus.notDetermined"
        case .restricted:
            return "CNAuthorizationStatus.restricted"
        case .denied:
            return "CNAuthorizationStatus.denied"
        case .authorized:
            return "CNAuthorizationStatus.authorized"
        @unknown default:
            return "CNAuthorizationStatus.unknown"
        }
    }
}

extension CNAuthorizationStatus: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .notDetermined:
            return "CNAuthorizationStatus.notDetermined: \(rawValue)"
        case .restricted:
            return "CNAuthorizationStatus.restricted: \(rawValue)"
        case .denied:
            return "CNAuthorizationStatus.denied: \(rawValue)"
        case .authorized:
            return "CNAuthorizationStatus.authorized: \(rawValue)"
        @unknown default:
            return "CNAuthorizationStatus.unknown"
        }
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ cnAuthorizationStatus: CNAuthorizationStatus) {
        appendLiteral(cnAuthorizationStatus.description)
    }
}

extension LocalizedStringKey.StringInterpolation {
    mutating func appendInterpolation(_ cnAuthorizationStatus: CNAuthorizationStatus) {
        appendLiteral(cnAuthorizationStatus.description)
    }
}
