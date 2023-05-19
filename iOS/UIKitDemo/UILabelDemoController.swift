//
//  UILabelDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/16.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UILabelDemoController: SHBaseViewController {
    private var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UILabelDemo"
        configureLabel()
    }
    
    private func configureLabel() {
        label = UILabel()
        label.backgroundColor = .blue
        label.text = "你知道，魔术师要是说穿了自己的把戏，别人就不会再夸赞他了。关于我的工作方法，要是我给你讲过多的话，你可能就会有这样的感觉这个福尔摩斯也不过如此，比一般人高明不到哪去。\n 你知道，魔术师要是说穿了自己的把戏，别人就不会再夸赞他了。关于我的工作方法，要是我给你讲过多的话，你可能就会有这样的感觉这个福尔摩斯也不过如此，比一般人高明不到哪去。"
        label.textColor = .orange
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.lineBreakMode = .byTruncatingHead
        label.lineBreakMode = .byTruncatingMiddle
        label.lineBreakMode = .byTruncatingTail
        label.lineBreakStrategy = .hangulWordPriority
        label.lineBreakStrategy = .pushOut
        label.lineBreakStrategy = .standard
        label.isEnabled = true
        //Size the Label's Text
//        label.adjustsFontSizeToFitWidth = true
//        label.allowsDefaultTighteningForTruncation = true
//        label.baselineAdjustment = .alignBaselines
//        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        
        label.highlightedTextColor = .red
        label.isHighlighted = true
        
        label.shadowColor = .yellow
        label.shadowOffset = CGSize(width: 5, height: 5)

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(200)
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
struct UILabelDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UILabelDemoController())
    }
}
#endif
