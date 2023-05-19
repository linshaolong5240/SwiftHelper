//
//  SHImageCollectionViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/2/11.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import SnapKit

class SHImageCollectionViewController: UIViewController {
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "ImageCollectionView"
        self.configureView()
    }
    
    private func configureView() {
        let imageCollectionView = SHImageCollectionView()
        self.view .addSubview(imageCollectionView)
        imageCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

#if DEBUG
struct SHImageCollectionViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(SHImageCollectionViewController()).ignoresSafeArea()
    }
}
#endif
