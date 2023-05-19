//
//  SHAPIError.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/29.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

enum SHAPIError: Error {
    case makeURLRqeusetError
    case decodeJSONDataToUTF8StringError
    case noResponseData
}

extension SHAPIError: LocalizedError  {
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .makeURLRqeusetError:
            return "make URLRequest error"
        case .decodeJSONDataToUTF8StringError:
            return "decode JSON data to utf8 string error"
        case .noResponseData:
            return "no response data"
        }
    }

    /// A localized message describing the reason for the failure.
    public var failureReason: String? {
        switch self {
        case .makeURLRqeusetError:
            return "make URLRequest error"
        case .decodeJSONDataToUTF8StringError:
            return "decode JSON data to string error"
        case .noResponseData:
            return "no response data"

        }
    }

    /// A localized message describing how one might recover from the failure.
    public var recoverySuggestion: String? { nil }

    /// A localized message providing "help" text if the user requests help.
    public var helpAnchor: String? { nil }
}
