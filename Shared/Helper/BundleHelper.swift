//
//  BundleHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/11.
//

import Foundation

enum InformationPropertyListKey: String, Identifiable, CaseIterable {
    var id: String { rawValue }
    case CFBundleIcons
}

extension Bundle {
    
    func informationPropertyList(key: InformationPropertyListKey) -> Any? {
        infoDictionary?[key.rawValue]
    }
    
}

extension Bundle {

    static var baseBundleIdentifier: String {
        let bundle = Bundle.main
        let packageType = bundle.object(forInfoDictionaryKey: "CFBundlePackageType") as? String
        let baseBundleIdentifier = bundle.bundleIdentifier!
        if packageType == "XPC!" {
            let components = baseBundleIdentifier.components(separatedBy: ".")
            return components[0..<components.count-1].joined(separator: ".")
        }
        
        return baseBundleIdentifier
    }
    
    static var sharedContainerIdentifier: String {
        let bundleIdentifier = baseBundleIdentifier
        return "group." + bundleIdentifier
    }

}
