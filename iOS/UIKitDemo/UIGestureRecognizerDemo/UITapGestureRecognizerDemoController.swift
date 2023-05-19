//
//  UITapGestureRecognizerDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UITapGestureRecognizerDemoController: SHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UITapGestureRecognizerDemo"
        configureTabGestureLabel()
    }
    
    private func configureTabGestureLabel() {
        let label = UILabel()
        label.backgroundColor = .systemPink
        label.isUserInteractionEnabled = true
        label.text = "UITapGestureRecognizer"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let singleFinger = UITapGestureRecognizer(target: self, action: #selector(handleSingleFingerTap))
        singleFinger.numberOfTapsRequired = 1
        singleFinger.numberOfTouchesRequired = 1
        label.addGestureRecognizer(singleFinger)
        
        let doubleFinger = UITapGestureRecognizer(target: self, action: #selector(handleDoubleFingerTap))
        doubleFinger.numberOfTapsRequired = 1
        doubleFinger.numberOfTouchesRequired = 2
        label.addGestureRecognizer(doubleFinger)
        
        singleFinger.require(toFail: doubleFinger)
    }
    
    @objc func handleSingleFingerTap(sender: UITapGestureRecognizer) {
        #if DEBUG
        print("\(#function)")
        #endif
    }
    
    @objc func handleDoubleFingerTap(sender: UITapGestureRecognizer) {
        #if DEBUG
        print("\(#function)")
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
struct UITapGestureRecognizerDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UITapGestureRecognizerDemoController())
    }
}
#endif
