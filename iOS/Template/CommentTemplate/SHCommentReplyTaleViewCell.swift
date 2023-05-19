//
//  SHCommentReplyTaleViewCell.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/14.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit

class SHCommentReplyTaleViewCell: UITableViewCell {
    private(set) var data: SHCommentReplyTaleViewCellData = SHCommentReplyTaleViewCellData(id: "", content: "")
    
    let contentLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView();
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
        self.contentLabel.font = UIFont.systemFont(ofSize: 16.0)
        self.contentLabel.numberOfLines = 0;
                
        self.contentView.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
    }
    
    public func fill(data: SHCommentReplyTaleViewCellData) {
        self.data = data;
        self.contentLabel.text = data.content;
    }
    
    public class func height(data: SHCommentReplyTaleViewCellData) -> CGFloat {
        print(data.content)
        return NSString(string: data.content).boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 32, height: CGFLOAT_MAX), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)], context: nil).height + 32
    }
    
}
