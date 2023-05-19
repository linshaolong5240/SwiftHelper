//
//  UILongPressGestureRecgnizerDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UILongPressGestureRecgnizerDemoController: SHBaseViewController {
    private var label: UILabel!
    private var status: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UILongPressGestureRecgnizerDemo"
        configureLongPressGestureLabel()
    }
    
    private func configureLongPressGestureLabel() {
        label = UILabel()
        label.backgroundColor = .systemPink
        label.isUserInteractionEnabled = true
        label.text = "UILongPressGestureRecognizer"
        view.addSubview(label)
        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
        let longPress = UILongPressGestureRecognizer(
          target: self,
          action: #selector(handleLongPress))
        label.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        #if DEBUG
        print("\(#function)")
        #endif
        status.toggle()
        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(status ? 100 : 50)
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
struct UILongPressGestureRecgnizerDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UILongPressGestureRecgnizerDemoController())
    }
}
#endif
