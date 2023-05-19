//
//  SHTestAViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/1/19.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

class SHTestAViewController: SHBaseViewController {
    let vc = SHTestBViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = .orange
        button.setTitle("button A", for: .normal)
        button .addTarget(self, action: #selector(buttonOnClicked), for: .touchUpInside)
        self.view.addSubview(button)
        
        let viewA = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        viewA.backgroundColor = UIColor(white:0.000, alpha:0.000)
        self.view.addSubview(viewA)

        
//        vc.willMove(toParent: self)
//        self.addChild(vc)
//        self.view.addSubview(vc.view)
//        vc.didMove(toParent: self)
    }

    @objc func buttonOnClicked(sender: UIButton, event: UIControl.Event) {
        self.view.backgroundColor = .yellow
    }
}

class SHTestBViewController: SHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .clear
//        self.view.isUserInteractionEnabled = false
        
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        button.backgroundColor = .purple
        button.setTitle("button B", for: .normal)
        button .addTarget(self, action: #selector(buttonOnClicked), for: .touchUpInside)
        self.view.addSubview(button)

    }
    
    @objc func buttonOnClicked(sender: UIButton, event: UIControl.Event) {
//        self.view.backgroundColor = .blue
    }
}

struct SHTestAViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(
            SHTestAViewController())
        .ignoresSafeArea()
//        .previewInterfaceOrientation(.landscapeLeft)
    }
}
