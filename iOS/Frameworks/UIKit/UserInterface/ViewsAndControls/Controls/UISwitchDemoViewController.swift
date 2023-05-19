//
//  UISwitchDemoViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/16.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

class UISwitchDemoViewController: SHSafeAreaContentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView()
    }
    
    private func configureView() {
        let switcher = UISwitch()
        self.contentView.addArrangedSubview(switcher);
    }

}

struct UISwitchDemoViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(
            UISwitchDemoViewController())
        .ignoresSafeArea()
//        .previewInterfaceOrientation(.landscapeLeft)
    }
}
