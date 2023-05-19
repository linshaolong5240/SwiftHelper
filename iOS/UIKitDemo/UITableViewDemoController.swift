//
//  UITableViewDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/5/27.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

class UITableViewDemoController: SHBaseViewController {
    private var tableView: UITableView!
    private var sections: [SHTableSection<String, String>] = [SHTableSection(label: "section1", items: Array<String>(repeating: "section1 item", count: 20)), SHTableSection(label: "section2", items: Array<String>(repeating: "section2 item", count: 20))]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UITableViewDemo"
//        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonOnClicked))
//        self.navigationItem.setRightBarButton(editButton, animated: true)
        configureTableView()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .purple
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemPink
        tableView.separatorInset = .init(top: 10, left: 20, bottom: 10, right: 20)
        tableView.separatorInsetReference = .fromCellEdges
        tableView.sectionIndexColor = .systemPink;

//        tableView.separatorInsetReference = .fromAutomaticInsets
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 100
        } else {
            // Fallback on earlier versions
        }
//        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.allowsSelection = true;
        tableView.register(UITableViewDemoCell.self, forCellReuseIdentifier: UITableViewDemoCell.reusedIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isEditing = true
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        tableHeaderView.backgroundColor = .blue
        tableView.tableHeaderView = tableHeaderView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
//            make.edges.equalToSuperview()
        }
    }
}

#if DEBUG
struct UITableViewDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UITableViewDemoController()).ignoresSafeArea()
    }
}
#endif

extension UITableViewDemoController: UITableViewDataSource {
    //Providing the Number of Rows and Sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    //Providing Cells, Headers, and Footers
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewDemoCell.reusedIdentifier, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        cell.setSelected(false, animated: true)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Header: \(section)"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "Footer: \(section)"
    }
    
    //Inserting or Deleting Table Rows
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            sections[indexPath.section].items.remove(at: indexPath.row)
        case .insert:
            break
        case .none:
            break
        @unknown default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    //Reordering Table Rows
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    //Configuring an Index
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let str = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,#"
        return str.split(separator: ",").map(String.init)
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        #if DEBUG
        print("\(#function) sectionForSectionIndexTitle: \(title) index: \(index)")
        #endif
        return index;
    }
}

extension UITableViewDemoController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UILabel()
        v.backgroundColor = .orange
        v.text = "Header: \(section)"
        return v
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UILabel()
        v.backgroundColor = .orange
        v.text = "Footer: \(section)"
        return v
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        #if DEBUG
        print("\(#function) indexPath: \(indexPath)")
        #endif
    }
}
