//
//  UIButton+Extension.swift
//  SwiftHelper (iOS)
//
//  Created by Apple on 2022/11/21.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import UIKit

extension UIButton {
    func alignVerticalImageText(spacing: CGFloat = 6.0) {
        guard let image = self.imageView?.image else {
            return
        }

        guard let titleLabel = self.titleLabel else {
            return
        }

        guard let titleText = titleLabel.text else {
            return
        }

        var titleSize: CGSize = .zero;
        if let font = titleLabel.font {
            titleSize = titleText.size(withAttributes: [
                NSAttributedString.Key.font: font
            ])
        }

        titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
}
