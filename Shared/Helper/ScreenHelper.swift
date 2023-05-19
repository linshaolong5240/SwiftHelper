//
//  ScreenHelper.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/3/4.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation
import CoreGraphics
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

struct ScreenHelper {
    static var mainScale: CGFloat {
        #if canImport(AppKit)
        return NSScreen.main?.backingScaleFactor ?? 1.0
        #endif
        #if canImport(UIKit)
        return UIScreen.main.scale
        #endif
    }
}

#if canImport(UIKit)
extension UIScreen {
    public static var screenType: ScreenType { screenInfo.type }
    public static var screenInfo: ScreenInfo {
        .init(size: self.main.bounds.size)
    }
}
#endif

public enum ScreenType {
#if os(iOS)
    case iPhone_428_926//iPhone 13 Pro Max
    case iPhone_414_896//iPhone 11 Pro Max
    case iPhone_414_736//iPhone 8 Plus
    case iPhone_390_844//iPhone 13 Pro iPhone 13
    case iPhone_375_812//Phone 11 Pro
    case iPhone_375_667//iPhone 8
    case iPhone_360_780_375_812_mini//for iPhone mini
    case iPhone_320_568
#endif
    case unknown
}

public struct ScreenInfo {
    var type: ScreenType
    var size: CGSize
    
#if os(iOS)
    //Fixed iPhone mini
    static var isMini: Bool {
        UIScreen.main.nativeBounds.size.equalTo(CGSize(width: 1080, height: 2340))
    }
#endif
    
    init(size: CGSize) {
        switch size {
#if os(iOS)
        case CGSize(width: 428, height: 926):
            self.type = .iPhone_428_926
            self.size = CGSize(width: 428, height: 926)
        case CGSize(width: 414, height: 896):
            self.type = .iPhone_414_896
            self.size = CGSize(width: 414, height: 896)
        case CGSize(width: 414, height: 736):
            self.type = .iPhone_414_736
            self.size = CGSize(width: 414, height: 736)
        case CGSize(width: 390, height: 844):
            self.type = .iPhone_390_844
            self.size = CGSize(width: 390, height: 844)
        case CGSize(width: 375, height: 812):
            if ScreenInfo.isMini {
                self.type = .iPhone_360_780_375_812_mini
                self.size = CGSize(width: 360, height: 780)
            } else {
                self.type = .iPhone_375_812
                self.size = CGSize(width: 375, height: 812)
            }
        case CGSize(width: 375, height: 667):
            self.type = .iPhone_375_667
            self.size = CGSize(width: 375, height: 667)
        case CGSize(width: 360, height: 780):
            self.type = .iPhone_360_780_375_812_mini
            self.size = CGSize(width: 360, height: 780)
        case CGSize(width: 320, height: 568):
            self.type = .iPhone_320_568
            self.size = CGSize(width: 320, height: 568)
#endif
        default:
            self.type = .unknown
            self.size = size
        }
    }
}


