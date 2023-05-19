//
//  SHImageCollectionViewCell.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/2/11.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit
import SnapKit

class SHImageCollectionViewCell: UICollectionViewCell {
    
    private(set) var imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
