//
//  UINavigationBarCustomDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/14.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

class UINavigationBarCustomDemoController: SHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UINavigationBarCustomDemo"
        
//        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(rightBarButtonItemOnClicked(button:)))
        
        let button = UIBarButtonItem(title: "rightBarButton", style: .plain, target: self, action: #selector(rightBarButtonItemOnClicked(button:event:)))

        self.navigationItem.rightBarButtonItem = button;
    }
    
    @objc func rightBarButtonItemOnClicked(button: UIBarButtonItem, event: UIControl.Event) {
        #if DEBUG
        print("\(#function) event: \(event)")
        #endif
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
struct UINavigationCustomDemoController_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlatformViewControllerRepresent(UINavigationBarCustomDemoController())//.ignoresSafeArea()
        }
    }
}
#endif
