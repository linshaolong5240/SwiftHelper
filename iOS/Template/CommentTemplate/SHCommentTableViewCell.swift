//
//  SHCommentTableViewCell.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/14.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit
import SnapKit

class SHCommentTableViewCell: UITableViewCell {
    private(set) var data: SHCommentTableViewCellData = SHCommentTableViewCellData(id: "", content: "", replys: [])
    
    let contentLabel = UILabel()

    private let tableView: UITableView = UITableView()
    
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
        
        self.tableView.backgroundColor = UIColor.orange
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(SHCommentReplyTaleViewCell.self, forCellReuseIdentifier: "\(SHCommentReplyTaleViewCell.self)")
        
        let vstack = UIStackView(arrangedSubviews: [
            self.contentLabel,
            self.tableView,
        ])
        vstack.axis = .vertical
        
        self.contentView.addSubview(vstack)
        vstack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
    }
    
    public func fill(data: SHCommentTableViewCellData) {
        self.data = data;
        self.contentLabel.text = data.content;
    }
    
    public class func height(data: SHCommentTableViewCellData) -> CGFloat {
        print(data.content)
        let tableViewHeight = data.replys.map { data in
            SHCommentReplyTaleViewCell.height(data: data)
        }
        .reduce(0) { partialResult, value in
            partialResult + value
        }
        
        return NSString(string: data.content).boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 32, height: CGFLOAT_MAX), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)], context: nil).height + 32 + tableViewHeight
    }
}

extension SHCommentTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.replys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SHCommentReplyTaleViewCell.self)", for: indexPath) as! SHCommentReplyTaleViewCell
        cell.fill(data: self.data.replys[indexPath.row])
        return cell;
    }
}

extension SHCommentTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        SHCommentReplyTaleViewCell.height(data: self.data.replys[indexPath.row])
    }
}
