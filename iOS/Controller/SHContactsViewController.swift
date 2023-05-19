//
//  SHContactsViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/12/22.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import SwiftUI
import Contacts

class SHContactsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

#if DEBUG
struct SHContactsViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(
            SHContactsViewController())
        .ignoresSafeArea()
//        .previewInterfaceOrientation(.landscapeLeft)
    }
}
#endif
