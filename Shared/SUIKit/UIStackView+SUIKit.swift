//
//  UIStackView+SUIKit.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/2.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
    }
    
    class func hstack(arrangedSubviews: [UIView], spacing: CGFloat, distribution: UIStackView.Distribution) -> UIStackView {
        return UIStackView(arrangedSubviews: arrangedSubviews, axis: .horizontal, spacing: spacing, distribution: distribution)
    }
    
    class func hstack(arrangedSubviews: [UIView], spacing: CGFloat) -> UIStackView {
        return UIStackView.hstack(arrangedSubviews: arrangedSubviews, spacing: spacing, distribution: .fill)
    }
    
    class func hstack(arrangedSubviews: [UIView]) -> UIStackView {
        return UIStackView.hstack(arrangedSubviews: arrangedSubviews, spacing: 0, distribution: .fill)
    }
    
    class func vstack(arrangedSubviews: [UIView], spacing: CGFloat, distribution: UIStackView.Distribution) -> UIStackView {
        return UIStackView(arrangedSubviews: arrangedSubviews, axis: .vertical, spacing: spacing, distribution: distribution)
    }
    
    class func vstack(arrangedSubviews: [UIView], spacing: CGFloat) -> UIStackView {
        return UIStackView.vstack(arrangedSubviews: arrangedSubviews, spacing: spacing, distribution: .fill)
    }
    
    class func vstack(arrangedSubviews: [UIView]) -> UIStackView {
        return UIStackView.vstack(arrangedSubviews: arrangedSubviews, spacing: 0, distribution: .fill)
    }
}
