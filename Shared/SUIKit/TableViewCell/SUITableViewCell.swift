//
//  SUITableViewCell.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/5.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit
import SnapKit

class SUITableViewCell: UITableViewCell {
    
    weak var selectorDelegate: AnyObject? = nil
    
    let containerView: UIView = UIView()
    
    let divider: UIView = UIView()
    
    var dividerInsets: UIEdgeInsets {
        didSet {
            self.divider.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(self.dividerInsets.bottom)
                make.left.equalToSuperview().inset(self.dividerInsets.left)
                make.right.equalToSuperview().inset(self.dividerInsets.right)
                make.height.equalTo(1)
            }
        }
    }

    var contentInsets: UIEdgeInsets {
        didSet {
            self.containerView.snp.makeConstraints { make in
                make.edges.equalTo(self.contentView).inset(self.contentInsets)
            }
        }
    }

    var containerInsets: UIEdgeInsets { .init(top: 12, left: 12, bottom: 12, right: 12) }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.dividerInsets = .init(top: 0, left: 12, bottom: 0, right: 12)
        self.contentInsets = .zero
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.divider.isHidden = true;
        self.divider.backgroundColor = SUIColor.dividerColor;
        self.containerView.backgroundColor = self.backgroundColor;
        
        self.containerView.addSubview(self.divider)
        self.divider.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(self.dividerInsets.bottom)
            make.left.equalToSuperview().inset(self.dividerInsets.left)
            make.right.equalToSuperview().inset(self.dividerInsets.right)
            make.height.equalTo(1)
        }
        self .contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(self.contentInsets)
        }
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

}
