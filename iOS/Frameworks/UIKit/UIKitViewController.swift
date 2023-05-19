//
//  UIKitViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/14.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

enum UIKitSection: String, CaseIterable {
    case UserInterface
    
    var items:[String] {
        switch self {
        case .UserInterface:
            return UIKitUserInterfaceSection.allCases.map(\.rawValue)
        }
    }
}

enum UIKitCustomItem: String, CaseIterable {
    case CarouselViewDemo
    case SHAdditionalInfoEditView
    case SHValueStepper
}

enum UIKitUserInterfaceSection: String, CaseIterable {
    case Controls
}



enum UIKitItem: String, CaseIterable {
    case AttributedStringDemo
    case AVPlayerViewDemo
    case AVPlayerViewControllerDemo
    case UIButtonDemo
    case UICollectionViewDemo
    case UICollectionViewHorizontalDemo
    case UIGestureRecognizerDemo
    case UILabelDemo
    case UIModalPresentationStyle
    case UINavigationBarCustomDemo
    case UIPageViewDemo
    case UIScrollViewDemo
    case UISearchControllerDemo
    case UISegmentedControl
    case UIStackViewDemo
    case UITabBarDemo
    case UITableViewDemo
    case UITextFieldDemo
    case UITextViewDemo
}

class UIKitViewController: UIViewController {
    
    private var tableView: UITableView!
    
    private let sections: [SHStringArraySection<String>] = UIKitSection.allCases.map { section in
        SHStringArraySection(title: section.rawValue, items: section.items)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        view.backgroundColor = .systemPink
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureTableView()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        //        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        //        tableView.allowsSelection = true
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reusedIdentifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

#if DEBUG
struct UIKItHomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlatformViewControllerRepresent(UIKitViewController()).ignoresSafeArea()
        }
    }
}
#endif

extension UIKitViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reusedIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = "\(sections[indexPath.section].items[indexPath.row])"
        cell.setSelected(false, animated: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
}

//extension UIKitViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//#if DEBUG
//        print("\(#function) \(indexPath)")
//#endif
//        let section = UIKitSection(rawValue: self.sections[indexPath.section].title)!
//        var vc: UIViewController!;
//        switch section {
//        case .UserInterface:
//            let item = UIKitUserInterfaceSection(rawValue: self.sections[indexPath.section].items[indexPath.row])!
//            switch item {
//            case .Controls:
////                vc = UIKitUserInterfaceViewController()
////            case .AttributedStringDemo:
////                vc = AttributedStringDemoController()
////            case .AVPlayerViewDemo:
////                vc = AVPlayerViewDemoController()
////            case .AVPlayerViewControllerDemo:
////                vc = AVPlayerViewControllerDemo()
////            case .UIButtonDemo:
////                vc = UIButtonDemoViewController()
////            case .UICollectionViewDemo:
////                vc = UICollectionViewDemoController()
////            case .UICollectionViewHorizontalDemo:
////                vc = UICollectionViewHorizontalDemoController()
////            case .UIGestureRecognizerDemo:
////                vc = UIGestureRecognizerDemoController()
////            case .UILabelDemo:
////                vc = UILabelDemoController()
////            case .UIModalPresentationStyle:
////                vc = UIModalPresentationStyleDemoViewController()
////            case .UINavigationBarCustomDemo:
////                vc = UINavigationBarCustomDemoController()
////            case .UIPageViewDemo:
////                vc = UIPageViewDemoController()
////            case .UIScrollViewDemo:
////                vc = UIScrollViewDemoController()
////            case .UISearchControllerDemo:
////                vc = UISearchControllerDemo()
////            case .UISegmentedControl:
////                vc = UISegmentedControlViewController()
////            case .UIStackViewDemo:
////                vc = UIStackViewDemoController()
////            case .UITabBarDemo:
////                vc = UITabBarDemoController()
////            case .UITableViewDemo:
////                vc = UITableViewDemoController()
////            case .UITextFieldDemo:
////                vc = UITextFieldDemoController()
////            case .UITextViewDemo:
////                vc = UITextViewDemoController()
//            }
//        }
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
