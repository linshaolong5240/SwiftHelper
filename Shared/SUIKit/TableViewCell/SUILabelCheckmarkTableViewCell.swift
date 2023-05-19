//
//  SUILabelCheckmarkTableViewCell.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/20.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit

class SUILabelCheckmarkTableViewCell: SUITableViewCell {
    
    let label: UILabel = UILabel()
    
    let checkmark: UIImageView = UIImageView(image: UIImage(systemName: "checkmark.circle"), highlightedImage: UIImage(systemName: "checkmark.circle.fill"))
    
    private(set) var data: SUILabelCheckmarkTableViewCellData = SUILabelCheckmarkTableViewCellData(text: "", isSelect: false)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.containerView.backgroundColor = .white
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.checkmark.isHighlighted = selected
        self.data.isSelect = selected
    }

    private func configureView() {
        let hstack = UIStackView.hstack(arrangedSubviews: [self.label, UIView(), self.checkmark])
        self.containerView.addSubview(hstack)
        hstack.snp.makeConstraints { make in
            make.edges.equalTo(self.containerInsets)
        }
    }
    
    public func fill(data: SUILabelCheckmarkTableViewCellData) {
        self.data = data
        self.label.text = data.text
    }
}
