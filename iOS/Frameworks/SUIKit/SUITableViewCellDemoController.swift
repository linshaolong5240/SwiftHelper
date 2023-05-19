//
//  SUITableViewCellDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/19.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

enum SUITableViewCellType: Int, CaseIterable {
    case labelCheckmark
    case labelSwitch
    
    var name: String {
        switch self {
        case .labelCheckmark:
            return "Label Checkmark"
        case .labelSwitch:
            return "Label Switch"
        }
    }
}

class SUITableViewCellDemoController: SHBaseViewController {
    private var items: [SUITableViewCellType] = SUITableViewCellType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "SUITableViewCell"
        self.configureView()
    }
    
    private func configureView() {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.backgroundColor = .clear
        tableView.register(SUILabelCheckmarkTableViewCell.self, forCellReuseIdentifier: "\(SUILabelCheckmarkTableViewCell.self)")
        tableView.register(SUILableSwitcherTableViewCell.self, forCellReuseIdentifier: "\(SUILableSwitcherTableViewCell.self)")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    @objc func switcherValueOnChanged(cell: SUILableSwitcherTableViewCell) {
        print("\(#function)")
        self.view.backgroundColor = cell.switcher.isOn ? .orange : .white

        if cell.switcher.isOn {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                cell.data.on = NO;
//            });
        } else {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                cell.data.on = YES;
//            });
        }
    }
}

extension SUITableViewCellDemoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = SUITableViewCellType(rawValue: indexPath.row)
        switch type {
        case .labelCheckmark:
            let cell: SUILabelCheckmarkTableViewCell = tableView.dequeueReusableCell(withIdentifier: "\(SUILabelCheckmarkTableViewCell.self)", for: indexPath) as! SUILabelCheckmarkTableViewCell
            cell.selectorDelegate = self
            let data = SUILabelCheckmarkTableViewCellData(text: self.items[indexPath.row].name, isSelect: false)
            cell.fill(data: data)
            cell.setCornerFor(index: indexPath.row, in: self.tableView(tableView, numberOfRowsInSection: 0), cornerRadius: 5)
            return cell
        case .labelSwitch:
            let cell: SUILableSwitcherTableViewCell = tableView.dequeueReusableCell(withIdentifier: "\(SUILableSwitcherTableViewCell.self)", for: indexPath) as! SUILableSwitcherTableViewCell
            cell.selectorDelegate = self
            let data = SUILableSwitcherTableViewCellData(text: self.items[indexPath.row].name, isOn: false, selector: #selector(switcherValueOnChanged))
            cell.fill(data: data)
            cell.setCornerFor(index: indexPath.row, in: self.tableView(tableView, numberOfRowsInSection: 0), cornerRadius: 5)
            return cell
        case .none:
            return UITableViewDemoCell()
        }
    }
}

extension SUITableViewCellDemoController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = SUITableViewCellType(rawValue: indexPath.row)
        switch type {
        case .labelCheckmark:
            let vc = SUILabelCheckmarkTableViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case .labelSwitch:
            break
        case .none:
            break
        }
    }
}

struct SUITableViewCellController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(
            SUITableViewCellDemoController())
        .ignoresSafeArea()
//        .previewInterfaceOrientation(.landscapeLeft)
    }
}
