//
//  UIGestureRecognizerDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

enum UIGestureRecognizerType: String, CaseIterable {
    case UITapGestureRecognizer
    case UILongPressGestureRecognizer
    case UISwipeGestureRecognizer
    case UIPanGestureRecognizer
    case UIPinchGestureRecognizer
    case UIRotationGestureRecognizer
}

class UIGestureRecognizerDemoController: SHBaseViewController {
    private var tableView: UITableView!
    private var sections: [SHTableSection<String, UIGestureRecognizerType>] = [SHTableSection(label: "section1", items: UIGestureRecognizerType.allCases)]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UIGestureRecognizerDemo"
        configureTableView()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reusedIdentifier)
        view.addSubview(tableView)
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

#if DEBUG
struct UIGestureRecognizerDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UIGestureRecognizerDemoController())
    }
}
#endif

extension UIGestureRecognizerDemoController: UITableViewDataSource {
    //Providing the Number of Rows and Sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    //Providing Cells, Headers, and Footers
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reusedIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].rawValue
        return cell
    }
}

extension UIGestureRecognizerDemoController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        #if DEBUG
        print("\(#function) indexPath: \(indexPath)")
        #endif
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        switch item {
        case .UITapGestureRecognizer:
            let vc = UITapGestureRecognizerDemoController()
            navigationController?.pushViewController(vc, animated: true)
        case .UILongPressGestureRecognizer:
            let vc = UILongPressGestureRecgnizerDemoController()
            navigationController?.pushViewController(vc, animated: true)
        case .UISwipeGestureRecognizer:
            let vc = UISwipeGestureRecognizerDemoController()
            navigationController?.pushViewController(vc, animated: true)
        case .UIPanGestureRecognizer:
            let vc = UIPanGestureRecognizerDemoController()
            navigationController?.pushViewController(vc, animated: true)
        case .UIPinchGestureRecognizer:
            let vc = UIPinchGestureRecognizerDemoController()
            navigationController?.pushViewController(vc, animated: true)
        case .UIRotationGestureRecognizer:
            let vc = UIRotationGestureRecognizerDemoController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
