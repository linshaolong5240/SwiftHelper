//
//  SHAdditionalInfoEditController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/12/27.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import UIKit

class SHAdditionalInfoEditController: SHBaseViewController {
    private var scrollView: UIScrollView!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView();
    }
    
    private func configureView() {
        
    }

}
