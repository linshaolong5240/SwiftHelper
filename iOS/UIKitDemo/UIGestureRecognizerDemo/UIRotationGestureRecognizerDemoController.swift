//
//  UIRotationGestureRecognizerDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UIRotationGestureRecognizerDemoController: SHBaseViewController {
    private var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UIRotationGestureRecognizerDemo"
        configureRotationGestureLabel()
    }
    
    private func configureRotationGestureLabel() {
        label = UILabel()
        label.backgroundColor = .systemPink
        label.isUserInteractionEnabled = true
        label.text = "UIRotationGestureRecognizer"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        let rotation = UIRotationGestureRecognizer(
          target: self,
          action: #selector(handleRotation))
        label.addGestureRecognizer(rotation)
    }
    
    @objc func handleRotation(sender: UIRotationGestureRecognizer) {
        #if DEBUG
        print("\(#function)")
        #endif
        let radian = sender.rotation
//        let angle = radian * (180 / CGFloat(Double.pi))

        label.transform = CGAffineTransform(rotationAngle: radian)
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
struct UIRotationGestureRecognizerDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UIRotationGestureRecognizerDemoController())
    }
}
#endif
