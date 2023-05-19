//
//  UIPanGestureRecognizerDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UIPanGestureRecognizerDemoController: SHBaseViewController {
    private var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UIPanGestureRecognizerDemo"
        configurePanGestureLabel()
    }
    
    private func configurePanGestureLabel() {
        label = UILabel()
        label.backgroundColor = .systemPink
        label.isUserInteractionEnabled = true
        label.text = "UIPanGestureRecognizer"
        view.addSubview(label)
        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
        let pan = UIPanGestureRecognizer(
          target: self,
          action: #selector(handlePan))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        label.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        #if DEBUG
        print("\(#function)")
        #endif
        let point = sender.location(in: view)
        label.snp.remakeConstraints { make in
            make.center.equalTo(point)
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
struct UIPanGestureRecognizerDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UIPanGestureRecognizerDemoController())
    }
}
#endif
