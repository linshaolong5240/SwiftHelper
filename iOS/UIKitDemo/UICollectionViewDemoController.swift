//
//  UICollectionViewDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/9.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UICollectionViewDemoController: SHBaseViewController {
    private let sections: [SHTableSection<String, UIColor>] = [SHTableSection(label: "section1", items: [UIColor].demoColors), SHTableSection(label: "section2", items: [UIColor].demoColors)]
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UICollectionViewDemo"
        configureCollectionView()
        self.navigationItem.rightBarButtonItem = editButtonItem
    }
    
    func configureCollectionView() {
        let columns: CGFloat = 3
        let padding: CGFloat = 10
        let paddingWidth = (columns - 1) * padding
        let width = (UIScreen.main.bounds.width - paddingWidth) / columns
        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = padding
        layout.headerReferenceSize = CGSize.init(width: UIScreen.main.bounds.width, height: 80)
        layout.footerReferenceSize = CGSize.init(width: UIScreen.main.bounds.width, height: 80)
        
        layout.itemSize = .init(width: width, height: 100)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsSelection = true;
        collectionView.allowsMultipleSelection = true
        collectionView.register(UICollectionViewDemoCell.self, forCellWithReuseIdentifier: UICollectionViewDemoCell.reusedIdentifier)
        collectionView.register(UICollectionViewDemoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UICollectionViewDemoHeaderView.reusedIdentifier)
        collectionView.register(UICollectionViewDemoFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: UICollectionViewDemoFooterView.reusedIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.selectItem(at: IndexPath(row: 1, section: 1), animated: false, scrollPosition: .top)
    }
}

#if DEBUG
struct UICollectionViewDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UICollectionViewDemoController()).ignoresSafeArea()
    }
}
#endif

extension UICollectionViewDemoController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewDemoCell.reusedIdentifier, for: indexPath) as! UICollectionViewDemoCell
        cell.titleLabel.text = "section:\(indexPath.section) row:\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UICollectionViewDemoHeaderView.reusedIdentifier, for: indexPath)
            v.backgroundColor = .purple
            return v
        }
        
        if kind == UICollectionView.elementKindSectionFooter {
            let v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: UICollectionViewDemoFooterView.reusedIdentifier, for: indexPath)
            v.backgroundColor = .orange
            return v
        }
        
        return UICollectionReusableView()
    }
    
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        ["A", "b", "c"]
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        true
    }
}

extension UICollectionViewDemoController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        #if DEBUG
        print("\(#function) \(indexPath)")
        #endif
    }
}
