//
//  UITabBarDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/1/21.
//

import SwiftUI

class UITabBarDemoController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        if #available(iOS 13.0, *) {
            let appearance: UITabBarAppearance = UITabBarAppearance()
            appearance.backgroundEffect = nil
            appearance.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            appearance.shadowColor = nil
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.green]
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.yellow]
            appearance.stackedLayoutAppearance.selected.iconColor = .green
            appearance.stackedLayoutAppearance.normal.iconColor = .yellow
            
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            } else {
                // Fallback on earlier versions
            }
        } else {
            // Fallback on earlier versions
        }
        tabBar.barTintColor = .orange
        tabBar.tintColor = .yellow
        tabBar.unselectedItemTintColor = .red
        tabBar.isTranslucent = false
//        tabBar.shadowImage = UIImage()
//        tabBar.backgroundImage = UIImage()
        configureTabBar()
    }
    
    func configureTabBar() {
        func makeTabBarViewController(viewController: UIViewController, title: String?, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
            let vc = UINavigationController(rootViewController: viewController)
            let tabBarItem: UITabBarItem = UITabBarItem(title: title, image: image?.withRenderingMode(.alwaysTemplate), selectedImage: selectedImage?.withRenderingMode(.alwaysTemplate))
            vc.tabBarItem = tabBarItem
            return vc
        }
        
        var vcs: [UIViewController] = []
        let vc1 = makeTabBarViewController(viewController: UIViewController(), title: "VC1", image: UIImage(systemName: "circle"), selectedImage: UIImage(systemName: "circle.fill"))
        vcs.append(vc1)
        let vc2 = makeTabBarViewController(viewController: UIViewController(), title: "VC2", image: UIImage(systemName: "rectangle"), selectedImage: UIImage(systemName: "rectangle.fill"))
        vcs.append(vc2)
        viewControllers = vcs
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
struct TabBarViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UITabBarDemoController()).ignoresSafeArea()
    }
}
#endif
