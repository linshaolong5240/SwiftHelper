//
//  SHCommentTableViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/14.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

class SHCommentTableViewController: SHBaseViewController {
    
    private var items: [SHCommentTableViewCellData] = []
    
    private var cellHeightDict: Dictionary<IndexPath, CGFloat> = Dictionary<IndexPath, CGFloat>()
    
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.items = [
            SHCommentTableViewCellData(id: "1",
                           content: "aaa",
                           replys: [
                            SHCommentReplyTaleViewCellData(id: "1", content: "aaa"),
                           ]),
            SHCommentTableViewCellData(id: "2",
                           content: "bbb\nbbb",
                           replys: [
                            SHCommentReplyTaleViewCellData(id: "1", content: "aaa"),
                            SHCommentReplyTaleViewCellData(id: "2", content: "bbb\nbbb"),
                           ]),
            SHCommentTableViewCellData(id: "3",
                           content: "ccc\nccc\nccc",
                           replys: [
                            SHCommentReplyTaleViewCellData(id: "1", content: "aaa"),
                            SHCommentReplyTaleViewCellData(id: "2", content: "bbb\nbbb"),
                            SHCommentReplyTaleViewCellData(id: "3", content: "ccc\nccc\nccc"),
                           ]),
            SHCommentTableViewCellData(id: "1",
                           content: "aaa",
                           replys: [
                            SHCommentReplyTaleViewCellData(id: "1", content: "aaa"),
                           ]),
            SHCommentTableViewCellData(id: "2",
                           content: "bbb\nbbb",
                           replys: [
                            SHCommentReplyTaleViewCellData(id: "1", content: "aaa"),
                            SHCommentReplyTaleViewCellData(id: "2", content: "bbb\nbbb"),
                           ]),
            SHCommentTableViewCellData(id: "3",
                           content: "ccc\nccc\nccc",
                           replys: [
                            SHCommentReplyTaleViewCellData(id: "1", content: "aaa"),
                            SHCommentReplyTaleViewCellData(id: "2", content: "bbb\nbbb"),
                            SHCommentReplyTaleViewCellData(id: "3", content: "ccc\nccc\nccc"),
                           ]),
        ]
        self.configureView();
    }
    
    private func configureView() {
        let tableView = UITableView(frame: self.view.bounds);
        tableView.register(SHCommentTableViewCell.self, forCellReuseIdentifier: "\(SHCommentTableViewCell.self)")
        tableView.register(SHCommentReplyTaleViewCell.self, forCellReuseIdentifier: "\(SHCommentReplyTaleViewCell.self)")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        self.tableView = tableView
    }
}

extension SHCommentTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SHCommentTableViewCell.self)", for: indexPath) as! SHCommentTableViewCell
        cell.fill(data: self.items[indexPath.row])
        return cell;
    }
}

extension SHCommentTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height: CGFloat = self.cellHeightDict[indexPath] {
            return height
        }

        let height: CGFloat = SHCommentTableViewCell.height(data: self.items[indexPath.row])
        self.cellHeightDict[indexPath] = height
        #if DEBUG
        print("height: \(height) for indexPath: \(indexPath)")
        #endif
        return SHCommentTableViewCell.height(data: self.items[indexPath.row])
    }
}

#if DEBUG
struct SHCommentTableViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(
            SHCommentTableViewController())
        .ignoresSafeArea()
//        .previewInterfaceOrientation(.landscapeLeft)
    }
}
#endif
