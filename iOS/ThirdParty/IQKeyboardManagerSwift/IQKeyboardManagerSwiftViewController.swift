//
//  IQKeyboardManagerSwiftViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/12/28.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift

class IQKeyboardManagerSwiftViewController: SHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "IQKeyboardManagerSwift"
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = false;
    }
    
    private func configureView() {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.textColor = .orange
        textView.font = .systemFont(ofSize: 20, weight: .bold)
        textView.text = "你知道，魔术师要是说穿了自己的把戏，别人就不会再夸赞他了。关于我的工作方法，要是我给你讲过多的话，你可能就会有这样的感觉这个福尔摩斯也不过如此，比一般人高明不到哪去。"
        textView.keyboardType = .default
        textView.returnKeyType = .default
        textView.isEditable = true
        textView.isSelectable = true
//        textView.delegate = self
        
        let container = UIView()
        container.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        }
        
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}
