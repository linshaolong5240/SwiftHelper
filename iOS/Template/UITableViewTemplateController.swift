//
//  UITableViewTemplateController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/13.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

class UITableViewTemplateController: UIViewController {
    
    private var items: [String] = ["aaa", "bbb", "ccc"]
    
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView();
    }
    
    private func configureView() {
        let tableView = UITableView(frame: self.view.bounds)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        headerView.backgroundColor = UIColor.orange
        tableView.tableHeaderView = headerView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        self.tableView = tableView
    }
}

extension UITableViewTemplateController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
}

extension UITableViewTemplateController: UITableViewDelegate {
    
}

struct UITableViewTemplateController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(
            UITableViewTemplateController())
        .ignoresSafeArea()
//        .previewInterfaceOrientation(.landscapeLeft)
    }
}
