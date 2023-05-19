//
//  UIApplication+Extension.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/1/18.
//

import  UIKit

extension UIApplication {
    static var rootViewController: UIViewController? {
        if #available(iOS 13.0, *) {
            //            UIApplication
            //            .shared
            //            .connectedScenes
            //            .compactMap { $0 as? UIWindowScene }
            //            .flatMap { $0.windows }
            //            .first { $0.isKeyWindow }
            //            ?.rootViewController
            return UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController
        }else {
            return UIApplication.shared.keyWindow?.rootViewController
        }
    }
    
    static var statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}
