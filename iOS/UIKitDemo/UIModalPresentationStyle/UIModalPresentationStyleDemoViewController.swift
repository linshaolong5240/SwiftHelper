//
//  UIModalPresentationStyleDemoViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/12/10.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import UIKit
import SnapKit

extension UIModalPresentationStyle: CaseIterable {
    var name: String {
        switch self {
        case .fullScreen:
            return "fullScreen"
        case .pageSheet:
            return "pageSheet"
        case .formSheet:
            return "formSheet"
        case .currentContext:
            return "currentContext"
        case .custom:
            return "custom"
        case .overFullScreen:
            return "overFullScreen"
        case .overCurrentContext:
            return "overCurrentContext"
        case .popover:
            return "popover"
        case .blurOverFullScreen:
            return "blurOverFullScreen"
        case .none:
            return "none"
        case .automatic:
            return "automatic"
        @unknown default:
            fatalError()
        }
    }
    public static var allCases: [UIModalPresentationStyle] {
        return [.fullScreen, .pageSheet, .formSheet, .currentContext, .custom, .overFullScreen, .overCurrentContext, .popover, .none, .automatic];
    }
}

class UIModalPresentationStyleDemoViewController: SHBaseViewController {
    
    private var items: [UIModalPresentationStyle] = UIModalPresentationStyle.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView()
    }
    
    private func configureView() {
        let tableView = UITableView();
        tableView.register(UITableViewDemoCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIModalPresentationStyleDemoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = self.items[indexPath.row].name
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
}

extension UIModalPresentationStyleDemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIModalPresentationStyleViewController()
        vc.modalPresentationStyle = self.items[indexPath.row]
        self.present(vc, animated: true)
    }
}
