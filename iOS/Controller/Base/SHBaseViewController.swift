//
//  SHBaseViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/3/25.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import UIKit
import SnapKit

class SHBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hidesBottomBarWhenPushed = true
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = SUIColor.controllerBackgroundColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setSupportOrientation(.all)
    }
    
    public func addSafeAreaBottomView(contentView: UIView, height: CGFloat, backgroundColor: UIColor) {
        let container = UIView()
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
//            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview();
            make.height.equalTo(height)
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = backgroundColor;
        container.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        container.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(container)
        }
    }
}
