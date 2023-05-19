//
//  SHScrollViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/17.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import UIKit

class SHScrollViewController: SHBaseViewController {
    open var scrollView: UIScrollView!
    open var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureScrollView()
        configureStackView()
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureStackView() {
        stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
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
