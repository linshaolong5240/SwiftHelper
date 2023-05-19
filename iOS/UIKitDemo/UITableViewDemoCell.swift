//
//  UITableViewDemoCell.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/10/13.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import UIKit

class UITableViewDemoCell: UITableViewCell {
    public let titleLabel: UILabel = UILabel();
    public let markImageView: UIImageView = UIImageView(image: UIImage(systemName: "heart"), highlightedImage: UIImage(systemName: "heart.fill"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .gray
        self.backgroundView = backgroundView
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .white;
        self.selectedBackgroundView = selectedBackgroundView
    }

}
