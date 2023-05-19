//
//  UICollectionViewDemoFooterView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/14.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import UIKit
import SnapKit

class UICollectionViewDemoFooterView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let label = UILabel()
        label.text = "Footer"
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
