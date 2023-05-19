//
//  UIModalPresentationStyleViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/12/12.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import UIKit

class UIModalPresentationStyleViewController: SHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5);
        self.configureView()
    }
    
    private func configureView() {
        let titleLabel = UILabel()
        titleLabel.text = self.modalPresentationStyle.name
        titleLabel.textAlignment = .center
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.accentColor
        button.layer.cornerRadius = 6;
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(buttonOnClicked), for: .touchUpInside)
        let vstack = UIStackView(arrangedSubviews: [titleLabel, button])
        vstack.axis = .vertical
        vstack.spacing = 10
        button.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        let container = UIView()
        container.addSubview(vstack)
        vstack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
        self.addSafeAreaBottomView(contentView: container, height: 32 + 44 + 10 + 20, backgroundColor: .blue)
    }
    
    @objc func buttonOnClicked(button: UIButton, event: UIControl.Event) {
        self.dismiss(animated: true)
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
