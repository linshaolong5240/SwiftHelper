//
//  SHAdditionalInfoEditViewDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/10/31.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import UIKit

class SHAdditionalInfoEditViewDemoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "SHAdditionalInfoEditView"
        
        let v = SHAdditionalInfoEditView()
        self.view .addSubview(v)
        v.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(300)
        }
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
