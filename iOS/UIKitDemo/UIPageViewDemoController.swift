//
//  UIPageViewDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/15.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UIPageViewDemoController: SHBaseViewController {
    private let vcs: [UIViewController] = [UIColor].demoColors.map({ color in
        let vc = UIViewController()
        vc.view.backgroundColor = color
        return vc
    })

    private var pageController: SHPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UIPageViewDemo"
        configurePageController()
    }
    
    func configurePageController() {
        pageController = SHPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.isCycleScroll = true
        pageController.setControllers(vcs)
        pageController.setPage(page: 2, animated: true)
        
        view.addSubview(pageController.view)
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
struct UIPageViewDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UIPageViewDemoController()).ignoresSafeArea()
    }
}
#endif
