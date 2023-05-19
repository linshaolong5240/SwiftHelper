//
//  UIScrollViewDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/5/30.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UIScrollViewDemoController: SHBaseViewController {
    private let items = Array<Int>(1...100)
    private var scrollView: UIScrollView!
    private var container: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UIScrollViewDemo"
        configureScrollView()
        configureContainer()
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureContainer() {
        container = UIStackView(frame: .zero)
        container.axis = .vertical
        scrollView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        items.map { item -> UIView in
            let label = UILabel()
            label.text = "\(item)"
            return label
        }
        .forEach { item in
            container.addArrangedSubview(item)
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
struct UIScrollViewDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UIScrollViewDemoController()).ignoresSafeArea()
    }
}
#endif
