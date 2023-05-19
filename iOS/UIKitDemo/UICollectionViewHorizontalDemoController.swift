//
//  UICollectionViewHorizontalDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/16.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit

class UICollectionViewHorizontalDemoController: SHBaseViewController {
    private var collectionViewHeight: CGFloat = 200
    
    private var collectionView: UICollectionHorizontalView!
    private var slider: UISlider!
    private var valueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureCollectionView()
        configureSlider()
        configureValueLabel()
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionHorizontalView()
        collectionView.backgroundColor = .systemPink
        view.addSubview(collectionView)
        collectionView.snp.remakeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(collectionViewHeight)
        }
    }
    
    private func configureSlider() {
        slider = UISlider()
        slider.minimumValue = 100
        slider.maximumValue = 500
        slider.value = 200
        slider.isContinuous = true

        slider.addTarget(self, action: #selector(onSliderValueChanged), for: .valueChanged)
        view.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalToSuperview().inset(20)
        }
    }
    
    private func configureValueLabel() {
        valueLabel = UILabel()
        valueLabel.text = "\(slider.value)"
        
        view.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(slider.snp.top).offset(-10)
        }
    }
    
    @objc func onSliderValueChanged(sender: UISlider, forEvent event: UIEvent) {
        print("\(#function): \(sender.value)")
        valueLabel.text = "\(sender.value)"
        collectionViewHeight = CGFloat(sender.value)
        collectionView.snp.remakeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(collectionViewHeight)
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
struct UICollectionViewHorizontalDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(UICollectionViewHorizontalDemoController()).ignoresSafeArea()
    }
}
#endif

