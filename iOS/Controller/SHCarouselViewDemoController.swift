//
//  SHCarouselViewDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/20.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class SHCarouselViewDemoController: SHBaseViewController {
    private var container: UIStackView!
    private var carouselView1: SHCarouselView!
    private var carouselView2: SHCarouselView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureContainer()
        configureCarouseView1()
        configureCarouseView2()
    }
    
    private func configureContainer() {
        container = UIStackView(frame: .zero)
        container.axis = .vertical
        container.spacing = 10
        container.distribution = .fillEqually
        view.addSubview(container)
        container.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(340)
        }
    }
    
    private func configureCarouseView1() {
        carouselView1 = SHCarouselView(frame: .zero, scrollDirection: .horizontal, showPageIndicator: true, timeInterval: TimeInterval(2))
        carouselView1.register(SHCarouselViewDemoCell.self, forCellWithReuseIdentifier: SHCarouselViewDemoCell.reusedIdentifier)
        carouselView1.delegate = self
        container.addArrangedSubview(carouselView1)
    }
    
    private func configureCarouseView2() {
        carouselView2 = SHCarouselView(frame: .zero, scrollDirection: .vertical, showPageIndicator: true, timeInterval: TimeInterval(2))
        carouselView2.register(SHCarouselViewDemoCell.self, forCellWithReuseIdentifier: SHCarouselViewDemoCell.reusedIdentifier)
        carouselView2.delegate = self
        container.addArrangedSubview(carouselView2)
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
struct SHCarouselViewDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(SHCarouselViewDemoController()).ignoresSafeArea()
    }
}
#endif

extension SHCarouselViewDemoController: SHCarouselViewDelegate {
    public func carouselView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SHCarouselViewDemoCell.reusedIdentifier, for: indexPath) as? SHCarouselViewDemoCell
        let colors: [UIColor] = [.blue, .purple, .green]
        cell?.backgroundColor = colors[indexPath.row % colors.count]

        return cell ?? UICollectionViewCell()

    }
    
    public func carouselView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    public func carouselView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
