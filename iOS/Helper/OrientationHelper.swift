//
//  OrientationHelper.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/3/25.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import UIKit

//https://stackoverflow.com/questions/28938660/how-to-lock-orientation-of-one-view-controller-to-portrait-mode-only-in-swift
public protocol OrientationControllSupport {
    var orientationSupport: UIInterfaceOrientationMask { get set }
}

extension OrientationControllSupport {
    public var orientationSupport: UIInterfaceOrientationMask {
        get {
            OrientationController.orientationSupport
        }
        set {
            OrientationController.orientationSupport = newValue
        }
    }
    
    func setSupportOrientation(_ orientation: UIInterfaceOrientationMask) {
        OrientationController.orientationSupport = orientation
    }

    func setSupportOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation) {
        setSupportOrientation(orientation)
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}

extension AppDelegate: OrientationControllSupport { }

extension UIViewController: OrientationControllSupport { }

public struct OrientationController {
    static var orientationSupport: UIInterfaceOrientationMask = .all
}
