//
//  UISearchControllerDemo.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/21.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UISearchControllerDemo: SHBaseViewController {
    private var tableView: UITableView!
    private var searchController: UISearchController!
    private var resultsViewController: SearchResultsViewController!

    private var defaultSections: [SHTableSection<String, String>] = [SHTableSection(label: "section1", items: ["a", "aab", "aabc", "bbb", "bbbc", "bbbccd"]), SHTableSection(label: "section2", items: ["a", "aab", "aabc", "bbb", "bbbc", "bbbccd"])]
    
    private var sections: [SHTableSection<String, String>] = [SHTableSection(label: "section1", items: ["a", "aab", "aabc", "bbb", "bbbc", "bbbccd"]), SHTableSection(label: "section2", items: ["a", "aab", "aabc", "bbb", "bbbc", "bbbccd"])] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UISearchControllerDemo"
        configureSearchController()
        configureTableView()
    }
    
    private func configureSearchController() {
        resultsViewController = SearchResultsViewController()
        resultsViewController.setData(sections)
        searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.isTranslucent = true
//        searchController.searchBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        searchController.searchBar.barTintColor = .clear
//        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
//        let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField
//        textField?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        searchController.searchBar.placeholder = NSLocalizedString("Enter the city name", comment: "")
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        searchController.delegate = self
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero)
        tableView.tableHeaderView = searchController.searchBar
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reusedIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
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
struct UISearchControllerDemo_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UISearchControllerDemo())
    }
}
#endif

extension UISearchControllerDemo: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reusedIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Section: \(section)"
    }
}

extension UISearchControllerDemo: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

class SearchResultsViewController: SHBaseViewController {
    private var tableView: UITableView = UITableView(frame: .zero)
    private var defaultSections: [SHTableSection<String, String>] = []
    private var sections: [SHTableSection<String, String>] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
    }
    
    private func configureTableView() {
        if #available(iOS 11.0, *) {
             self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
             self.automaticallyAdjustsScrollViewInsets = false
        }

        tableView.backgroundColor = .clear
//        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reusedIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setData(_ sections: [SHTableSection<String, String>]) {
        defaultSections = sections
    }
}

extension SearchResultsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reusedIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        return cell
    }

    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        
    }
}

extension SearchResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension UISearchControllerDemo: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.count > 0 else {
            searchController.searchResultsController?.view.isHidden = false
            sections = defaultSections
            return
        }
        sections = defaultSections.map({ section in
            var temp = section
            let items = section.items.filter { str in
                str.contains(searchText)
            }
            temp.items = items
            return temp
        })
    }
}

extension UISearchControllerDemo: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
//        tableView.isHidden = true
    }
    func willDismissSearchController(_ searchController: UISearchController) {
//        tableView.isHidden = false
    }
}
