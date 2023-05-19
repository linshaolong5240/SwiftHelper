//
//  SHSafeAreaContentViewController.swift
//  SwiftHelper (iOS)
//
//  Created by Apple on 2022/12/20.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import UIKit
import SnapKit

class SHSafeAreaContentViewController: SHBaseViewController {
    public let contentView: UIStackView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.contentView = UIStackView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.contentView.axis = .vertical;
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
}
