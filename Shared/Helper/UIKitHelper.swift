//
//  UIKitHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2021/11/23.
//

import Foundation
#if canImport(UIKit)
import UIKit

protocol ReusableIdentifier: AnyObject {
    static var reusedIdentifier: String { get }
}

extension ReusableIdentifier {
    static var reusedIdentifier: String { "\(Self.self)" }
}

extension UIView: ReusableIdentifier {}
//extension UICollectionViewCell: ReusableIdentifier { }
//extension UITableViewCell: ReusableIdentifier { }

extension UIScreen {
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

#endif
