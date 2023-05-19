//
//  UISegmentedControlDemoViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/12/20.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import SwiftUI
import SnapKit

class UISegmentedControlDemoViewController: SHSafeAreaContentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "UISegmentedControl";
        configureView()
    }
    
    private func configureView() {
        let segmentControl = UISegmentedControl(items: ["aaa", "bbb", "cccc"])
        segmentControl.addTarget(self, action: #selector(segmentControlValueOnChanged), for: .valueChanged)
        self.contentView.addArrangedSubview(segmentControl)
        self.contentView.addArrangedSubview(UIView())
        segmentControl.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
    
    @objc func segmentControlValueOnChanged(segment: UISegmentedControl, event: UIControl.Event) {
        print("\(#function)")
    }
}

#if DEBUG
struct UISegmentedControlViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UISegmentedControlDemoViewController())
    }
}
#endif
