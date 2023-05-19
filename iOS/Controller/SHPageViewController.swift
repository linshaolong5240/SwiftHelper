//
//  SHPageViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/1/27.
//

import SwiftUI
import SnapKit

public class SHPageViewController: UIPageViewController {
    
    public var isCycleScroll: Bool = false
    
    private(set) var controllers: [UIViewController] = []
    
    lazy private(set) var pageControl = UIPageControl()
    
    private(set) var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
//    override init(transitionStyle: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]?) {
//        super.init(transitionStyle: transitionStyle, navigationOrientation: navigationOrientation, options: options)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
        configurepageControl()
    }
    
    private func configurepageControl() {
        pageControl.addTarget(self, action: #selector(pageControlOnClicked), for: .valueChanged)
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func pageControlOnClicked(sender: UIPageControl, forEvent event: UIEvent) {
        setPage(page: sender.currentPage, animated: true)
    }
    
    func setControllers(_ viewControllers: [UIViewController]) {
        guard !viewControllers.isEmpty else {
            return
        }
        
        self.controllers = viewControllers
        pageControl.numberOfPages = viewControllers.count > 1 ? viewControllers.count : 0
        setPage(page: 0, animated: false)
    }
    
    func setPage(page: Int, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        guard page < controllers.endIndex else {
            return
        }
        setViewControllers([controllers[page]], direction: page > currentPage ? .forward : .reverse, animated: animated, completion: completion)
        currentPage = page
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

extension SHPageViewController: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else {
            return nil
        }
        
        return index > controllers.indices.startIndex ? controllers[index - 1] : (isCycleScroll ? controllers.last : nil)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else {
            return nil
        }
        
        return index < controllers.indices.endIndex - 1 ? controllers[index + 1] : (isCycleScroll ? controllers.first : nil)
    }
}

extension SHPageViewController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        guard let currentViewController = pageViewController.viewControllers?.first, let index = controllers.firstIndex(of: currentViewController) else { return }
        currentPage = index
    }
}

struct PageViewControllerDemoView: View {
    var body: some View {
        ZStack {
            VStack {
                let colors: [UIColor] = [.systemPink, .orange, .blue, .yellow]
                let vcs: [UIViewController] = colors.map({ color in
                    let vc = UIViewController()
                    vc.view.backgroundColor = color
                    return vc
                })
                let vc: SHPageViewController = {
                    //interPageSpacing only for transitionStyle: .scroll
                    //spineLocation only for transitionStyle: .pageCurl
                    let vc = SHPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [.spineLocation: 0])
                    vc.isCycleScroll = true
                    return vc
                }()
                PlatformViewControllerRepresent(vc)
                    .onAppear(perform: {
                        vc.setControllers(vcs)
                        vc.setPage(page: 2, animated: true)
                    })
            }
        }.ignoresSafeArea()
    }
}

#if DEBUG
struct PageViewController_Previews: PreviewProvider {
    static var previews: some View {
        PageViewControllerDemoView()
    }
}
#endif

