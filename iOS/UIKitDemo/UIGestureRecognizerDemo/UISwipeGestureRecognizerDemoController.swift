//
//  UISwipeGestureRecognizerDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UISwipeGestureRecognizerDemoController: SHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UISwipeGestureRecognizerDemo"
        configureSwipeGestureLabel()
    }
    
    private func configureSwipeGestureLabel() {
        let label = UILabel()
        label.backgroundColor = .systemPink
        label.isUserInteractionEnabled = true
        label.text = "UISwipeGestureRecognizer"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(100)
        }
        
        let swipeUp = UISwipeGestureRecognizer(
          target: self,
          action: #selector(handSwipe))
        swipeUp.direction = .up
        swipeUp.numberOfTouchesRequired = 1
        label.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(
          target: self,
          action: #selector(handSwipe))
        swipeDown.direction = .down
        swipeDown.numberOfTouchesRequired = 1
        label.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(
          target: self,
          action: #selector(handSwipe))
        swipeLeft.direction = .left
        swipeLeft.numberOfTouchesRequired = 1
        label.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(
          target: self,
          action: #selector(handSwipe))
        swipeRight.direction = .right
        swipeRight.numberOfTouchesRequired = 1
        label.addGestureRecognizer(swipeRight)
    }
    
    @objc func handSwipe(sender: UISwipeGestureRecognizer) {
        #if DEBUG
        print("\(#function) \(sender.direction)")
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
struct UISwipeGestureRecognizerDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UISwipeGestureRecognizerDemoController())
    }
}
#endif
