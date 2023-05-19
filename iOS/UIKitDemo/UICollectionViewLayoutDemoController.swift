//
//  UICollectionViewLayoutDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/9.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

class UICollectionViewLayoutDemoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

#if DEBUG
struct UICollectionViewLayoutDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UICollectionViewLayoutDemoController()).ignoresSafeArea()
    }
}
#endif
