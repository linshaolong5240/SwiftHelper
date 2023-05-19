//
//  UIPinchGestureRecognizerDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UIPinchGestureRecognizerDemoController: SHBaseViewController {
    private var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UIPinchGestureRecognizerDemo"
        configurePinchGestureLabel()
    }
    
    private func configurePinchGestureLabel() {
        label = UILabel()
        label.backgroundColor = .systemPink
        label.isUserInteractionEnabled = true
        label.text = "UIPinchGestureRecognizer"
        view.addSubview(label)
        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        let pinch = UIPinchGestureRecognizer(
          target: self,
          action: #selector(handlePinch))
        label.addGestureRecognizer(pinch)
    }
    
    @objc func handlePinch(sender: UIPinchGestureRecognizer) {
        #if DEBUG
        print("\(#function) state: \(sender.state)")
        #endif
        switch sender.state {
        case .began:
            #if DEBUG
            print("\(#function) state: began")
            #endif
            break
        case .possible:
            #if DEBUG
            print("\(#function) state: possible")
            #endif
            break
        case .changed:
            #if DEBUG
            print("\(#function) state: changed")
            #endif
            let w = label.frame.width * sender.scale
            let h = label.frame.height * sender.scale
            
            if w >= 50 && w <= 300 && h >= 50 && h <= 300 {
                label.snp.remakeConstraints { make in
                    make.center.equalToSuperview()
                    make.size.equalTo(CGSize(width: w, height: h))
                }
            }
            break
        case .ended:
            #if DEBUG
            print("\(#function) state: ended")
            #endif
//            label.snp.remakeConstraints { make in
//                make.center.equalToSuperview()
//                make.size.equalTo(CGSize(width: 100, height: 100))
//            }
            break
        case .cancelled:
            #if DEBUG
            print("\(#function) state: cancelled")
            #endif
            break
        case .failed:
            #if DEBUG
            print("\(#function) state: failed")
            #endif
            break
        @unknown default:
            #if DEBUG
            print("\(#function) state: @unknown default")
            #endif
            break
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

#if DEBUG
struct UIPinchGestureRecognizerDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UIPinchGestureRecognizerDemoController())
    }
}
#endif
