//
//  UIButtonDemoViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/11/21.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import UIKit

class UIButtonDemoViewController: SHScrollViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureButton();
    }
    
    private func configureButton() {
        let button = UIButton(type: .custom)
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.accentColor, for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.addTarget(self, action: #selector(buttonOnClicked), for: .touchUpInside)
        self.stackView.addArrangedSubview(button)
        button.alignVerticalImageText();
    }
    
    @objc func buttonOnClicked(button: UIButton, event: UIControl.Event) {
        print("\(#function)")
    }
}
