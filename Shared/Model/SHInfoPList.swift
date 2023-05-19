//
//  SHInfoPListKey.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/8.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

public enum SHInfoPListKey: String, CaseIterable {
    //Bundle Condiguration
    //Categorization
    case CFBundlePackageType
    case LSApplicationCategoryType
    //Identification
    case CFBundleIdentifier
    case WKAppBundleIdentifier
    case WKCompanionAppBundleIdentifier
    //Naming
    case CFBundleName
    case CFBundleDisplayName
    case CFBundleSpokenName
    //Bundle Version
    case CFBundleVersion
    case CFBundleShortVersionString
    case CFBundleInfoDictionaryVersion
    case NSHumanReadableCopyright
    //Operating System Version
    case LSMinimumSystemVersion
    case LSMinimumSystemVersionByArchitecture
    case MinimumOSVersion
    case LSRequiresIPhoneOS
    case WKWatchKitApp
    //Localization
    case CFBundleDevelopmentRegion
    case CFBundleLocalizations
    case CFBundleAllowMixedLocalizations
    case TICapsLockLanguageSwitchCapable
    //Help
    case CFAppleHelpAnchor
    case CFBundleHelpBookName
    case CFBundleHelpBookFolder
}

extension SHInfoPListKey {
    func typeValue<T>() -> T? {
        Bundle.main.infoDictionary?[self.rawValue] as? T
    }
    
    var stringValue: String? { typeValue() }
    var resolvedStringValue: String { stringValue ?? "" }

    var boolValue: Bool? { typeValue() }
}

struct InfoPList {
    public static var appName: String { SHInfoPListKey.CFBundleName.resolvedStringValue }
    public static var appVersion: String { SHInfoPListKey.CFBundleShortVersionString.resolvedStringValue }
    public static var buildNumber: String { SHInfoPListKey.CFBundleVersion.resolvedStringValue }
    public static var displayName: String { SHInfoPListKey.CFBundleDisplayName.resolvedStringValue }
}

//Bundle Configuration
extension SHInfoPListKey {
    //Categorization
    public static var packageType: String { Bundle.main.infoDictionary?["CFBundlePackageType"] as? String  ?? ""}
    public static var lsApplicationCategoryType: String { Bundle.main.infoDictionary?["LSApplicationCategoryType"] as? String  ?? ""}
    //Identification
    public static var bundleIdentifier: String { Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String  ?? ""}
    public static var wkAppBundleIdentifier: String { Bundle.main.infoDictionary?["WKAppBundleIdentifier"] as? String  ?? ""}
}

#if DEBUG
import SwiftUI

struct APPEnvironmentDemoView: View {
    var body: some View {
        List {
            Text("App Name: \(InfoPList.appName)")
            Text("App Version: \(InfoPList.appVersion)")
            Text("App Build Number: \(InfoPList.buildNumber)")
            Text("App Display Name: \(InfoPList.displayName)")
        }
    }
}

struct APPEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        APPEnvironmentDemoView()
    }
}
#endif
