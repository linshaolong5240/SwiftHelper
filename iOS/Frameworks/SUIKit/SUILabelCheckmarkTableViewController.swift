//
//  SUILabelCheckmarkTableViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/20.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import SnapKit

class SUILabelCheckmarkTableViewController: SHBaseViewController {
    
    private var items: [SUILabelCheckmarkTableViewCellData] = [
        SUILabelCheckmarkTableViewCellData(text: "a", isSelect: false),
        SUILabelCheckmarkTableViewCellData(text: "b", isSelect: false),
        SUILabelCheckmarkTableViewCellData(text: "c", isSelect: true),
        SUILabelCheckmarkTableViewCellData(text: "d", isSelect: false),
        SUILabelCheckmarkTableViewCellData(text: "e", isSelect: false),
        SUILabelCheckmarkTableViewCellData(text: "f", isSelect: false),
    ]
    
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView();
        for (index, value) in self.items.enumerated() {
            if (value.isSelect) {
                self.tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .top)
            }
        }
    }
    
    private func configureView() {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.allowsMultipleSelection = true
        tableView.register(SUILabelCheckmarkTableViewCell.self, forCellReuseIdentifier: "\(SUILabelCheckmarkTableViewCell.self)")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        self.tableView = tableView
    }
}

extension SUILabelCheckmarkTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SUILabelCheckmarkTableViewCell.self)", for: indexPath) as! SUILabelCheckmarkTableViewCell
        cell.fill(data: self.items[indexPath.row])
        return cell
    }
}

extension SUILabelCheckmarkTableViewController: UITableViewDelegate {
    
}

struct SUILabelCheckmarkTableViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(
            SUILabelCheckmarkTableViewController())
        .ignoresSafeArea()
//        .previewInterfaceOrientation(.landscapeLeft)
    }
}
