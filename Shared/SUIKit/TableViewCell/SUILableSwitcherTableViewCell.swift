//
//  SUILableSwitcherTableViewCell.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/19.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import UIKit

class SUILableSwitcherTableViewCell: SUITableViewCell {
    
    let label: UILabel = UILabel()
    
    let switcher: UISwitch = UISwitch()
    
    private(set) var data: SUILableSwitcherTableViewCellData = SUILableSwitcherTableViewCellData(text: "", isOn: false)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.switcher.transform = CGAffineTransformMakeScale(0.75, 0.75)
        self.switcher .addTarget(self, action: #selector(switcherOnValuewChanged), for: .touchUpInside)
        let hstack = UIStackView .hstack(arrangedSubviews: [self.label, UIView(), self.switcher])
        self.containerView.addSubview(hstack)
        hstack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(self.containerInsets)
        }
    }
    
    @objc func switcherOnValuewChanged(sender: UISwitch, event:UIControl.Event) {
        if self.data.selector != nil && self.selectorDelegate != nil && self.selectorDelegate!.responds(to: self.data.selector!) {
            _ = self.selectorDelegate?.perform(self.data.selector!, with: self)
        }
    }
    
    public func fill(data: SUILableSwitcherTableViewCellData) {
        self.data = data;
        self.label.text = data.text;
        self.switcher.isOn = data.isOn;
    }
}
