//
//  SearchPathDirectory+Extension.swift
//  SwiftHelper
//
//  Created by sauron on 2023/4/30.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

extension FileManager.SearchPathDirectory: CaseIterable {
    public static var allCases: [FileManager.SearchPathDirectory] {
        #if os(macOS)
        [
                .applicationDirectory,
                .demoApplicationDirectory,
                .developerApplicationDirectory,
                .adminApplicationDirectory,
                .libraryDirectory,
                .developerDirectory,
                .userDirectory,
                .documentationDirectory,
                .documentDirectory,
                .coreServiceDirectory,
                .autosavedInformationDirectory,
                .desktopDirectory,
                .cachesDirectory,
                .applicationSupportDirectory,
                .downloadsDirectory,
                .inputMethodsDirectory,
                .moviesDirectory,
                .musicDirectory,
                .picturesDirectory,
                .printerDescriptionDirectory,
                .sharedPublicDirectory,
                .preferencePanesDirectory,
                .applicationScriptsDirectory,
                .itemReplacementDirectory,
                .allApplicationsDirectory,
                .allLibrariesDirectory,
                .trashDirectory,
        ]
        #else
        []
        #endif
    }
}

extension FileManager.SearchPathDirectory: CustomStringConvertible {
    public var description: String {
        switch self {
        case .applicationDirectory:
            return "applicationDirectory"
        case .demoApplicationDirectory:
            return "demoApplicationDirectory"
        case .developerApplicationDirectory:
            return "developerApplicationDirectory"
        case .adminApplicationDirectory:
            return "adminApplicationDirectory"
        case .libraryDirectory:
            return "libraryDirectory"
        case .developerDirectory:
            return "developerDirectory"
        case .userDirectory:
            return "userDirectory"
        case .documentationDirectory:
            return "documentationDirectory"
        case .documentDirectory:
            return "documentDirectory"
        case .coreServiceDirectory:
            return "coreServiceDirectory"
        case .autosavedInformationDirectory:
            return "autosavedInformationDirectory"
        case .desktopDirectory:
            return "desktopDirectory"
        case .cachesDirectory:
            return "cachesDirectory"
        case .applicationSupportDirectory:
            return "applicationSupportDirectory"
        case .downloadsDirectory:
            return "downloadsDirectory"
        case .inputMethodsDirectory:
            return "inputMethodsDirectory"
        case .moviesDirectory:
            return "moviesDirectory"
        case .musicDirectory:
            return "musicDirectory"
        case .picturesDirectory:
            return "picturesDirectory"
        case .printerDescriptionDirectory:
            return "printerDescriptionDirectory"
        case .sharedPublicDirectory:
            return "sharedPublicDirectory"
        case .preferencePanesDirectory:
            return "preferencePanesDirectory"
        case .applicationScriptsDirectory:
            return "applicationScriptsDirectory"
        case .itemReplacementDirectory:
            return "itemReplacementDirectory"
        case .allApplicationsDirectory:
            return "allApplicationsDirectory"
        case .allLibrariesDirectory:
            return "allLibrariesDirectory"
        case .trashDirectory:
            return "trashDirectory"
        @unknown default:
            return "unknown default"
        }
    }
}

extension FileManager.SearchPathDirectory: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .applicationDirectory:
            return "applicationDirectory: \(rawValue)"
        case .demoApplicationDirectory:
            return "demoApplicationDirectory: \(rawValue)"
        case .developerApplicationDirectory:
            return "developerApplicationDirectory: \(rawValue)"
        case .adminApplicationDirectory:
            return "adminApplicationDirectory: \(rawValue)"
        case .libraryDirectory:
            return "libraryDirectory: \(rawValue)"
        case .developerDirectory:
            return "developerDirectory: \(rawValue)"
        case .userDirectory:
            return "userDirectory: \(rawValue)"
        case .documentationDirectory:
            return "documentationDirectory: \(rawValue)"
        case .documentDirectory:
            return "documentDirectory: \(rawValue)"
        case .coreServiceDirectory:
            return "coreServiceDirectory: \(rawValue)"
        case .autosavedInformationDirectory:
            return "autosavedInformationDirectory: \(rawValue)"
        case .desktopDirectory:
            return "desktopDirectory: \(rawValue)"
        case .cachesDirectory:
            return "cachesDirectory: \(rawValue)"
        case .applicationSupportDirectory:
            return "applicationSupportDirectory: \(rawValue)"
        case .downloadsDirectory:
            return "downloadsDirectory: \(rawValue)"
        case .inputMethodsDirectory:
            return "inputMethodsDirectory: \(rawValue)"
        case .moviesDirectory:
            return "moviesDirectory: \(rawValue)"
        case .musicDirectory:
            return "musicDirectory: \(rawValue)"
        case .picturesDirectory:
            return "picturesDirectory: \(rawValue)"
        case .printerDescriptionDirectory:
            return "printerDescriptionDirectory: \(rawValue)"
        case .sharedPublicDirectory:
            return "sharedPublicDirectory: \(rawValue)"
        case .preferencePanesDirectory:
            return "preferencePanesDirectory: \(rawValue)"
        case .applicationScriptsDirectory:
            return "applicationScriptsDirectory: \(rawValue)"
        case .itemReplacementDirectory:
            return "itemReplacementDirectory: \(rawValue)"
        case .allApplicationsDirectory:
            return "allApplicationsDirectory: \(rawValue)"
        case .allLibrariesDirectory:
            return "allLibrariesDirectory: \(rawValue)"
        case .trashDirectory:
            return "trashDirectory: \(rawValue)"
        @unknown default:
            return "unknown default: \(rawValue)"
        }
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ searchPathDirectory: FileManager.SearchPathDirectory) {
        appendLiteral(searchPathDirectory.description)
    }
}

extension LocalizedStringKey.StringInterpolation {
    mutating func appendInterpolation(_ searchPathDirectory: FileManager.SearchPathDirectory) {
        appendLiteral(searchPathDirectory.description)
    }
}
