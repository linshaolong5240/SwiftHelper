//
//  SUITableViewCellCorner.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/18.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit

enum SUITableViewCellCorner {
    case none
    case all
    case top
    case bottom
}

extension SUITableViewCell {
    
    func setCornerFor(index: Int, in number: Int, cornerRadius: CGFloat) {
        func cornerFor(index: Int, in number: Int) -> SUITableViewCellCorner {
            if (index == 0 && number == 1) {
                return .all;
            }
            
            if (index == 0) {
                return .top;
            }
            
            if (index == (number - 1)) {
                return .bottom;
            }
            return .none;
        }
        
        func setCorners(maskedCorners: CACornerMask, cornerRadius: CGFloat, masksToBounds: Bool = true) {
            self.containerView.layer.cornerRadius = cornerRadius
            self.containerView.layer.maskedCorners = maskedCorners
            self.containerView.layer.masksToBounds = masksToBounds
        }
        
        let corner = cornerFor(index: index, in: number)
        
        switch corner {
        case .none:
            setCorners(maskedCorners: [], cornerRadius: 0)
        case .all:
            setCorners(maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], cornerRadius: 0)
        case .top:
            setCorners(maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], cornerRadius: cornerRadius)
        case .bottom:
            setCorners(maskedCorners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], cornerRadius: cornerRadius)
        }
        
    }
}
