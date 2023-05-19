//
//  UICollectionViewDemoCell.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/9/29.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import UIKit
import SnapKit

class UICollectionViewDemoCell: UICollectionViewCell {
    public let titleLabel: UILabel = UILabel();
    public let markImageView: UIImageView = UIImageView(image: UIImage(systemName: "heart"), highlightedImage: UIImage(systemName: "heart.fill"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func configureContentView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .gray
        self.backgroundView = backgroundView
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .orange
        self.selectedBackgroundView = selectedBackgroundView
        
        configureTitleLabel()
        configureMarkImageView()
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureMarkImageView() {
        contentView.addSubview(markImageView)
        markImageView.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
    }
}
