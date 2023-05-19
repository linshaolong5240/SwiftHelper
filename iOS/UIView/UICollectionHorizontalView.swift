//
//  CollectionViewHorizontal.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/2/24.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit
import Kingfisher

struct UICollectionHorizontalDemoView: View {
    @State private var height: CGFloat = 200
    
    var body: some View {
        ZStack {
            PlatformViewRepresent(UICollectionHorizontalView())
                .frame(height: height)
            .background(Color.pink)
            VStack {
                Spacer()
                Slider(value: $height, in: 100...400) {
                    Text("Speed")
                } minimumValueLabel: {
                    Text("100")
                } maximumValueLabel: {
                    Text("400")
                }
            }
            .padding()
        }
    }
}

#if DEBUG
struct UICollectionHorizontalDemoView_Previews: PreviewProvider {
    static var previews: some View {
        UICollectionHorizontalDemoView()
    }
}
#endif

class UICollectionViewHorizontalCell: UICollectionViewCell {
    private(set) var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        configurationImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurationImageView() {
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
//        imageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
    
    func setData(_ url: URL) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url){ [weak self]
            result in
            guard let weakSelf = self else {
                return
            }
            switch result {
            case .success(let value):
                let width: CGFloat = weakSelf.frame.width
                let height: CGFloat = width * value.image.size.height / value.image.size.width
                weakSelf.imageView.snp.remakeConstraints { make in
                    make.center.equalToSuperview()
                    make.size.equalTo(CGSize(width: width, height: height))
                }
                #if DEBUG
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                #endif
            case .failure(let error):
                #if DEBUG
                print("Job failed: \(error.localizedDescription)")
                #endif
            }
        }
    }
}

class UICollectionHorizontalView: UIView {
    var _cellWidth: CGFloat = 375
    var _cellHeight: CGFloat = 812

    var cellWidth: CGFloat {
        if frame.width > frame.height {
            return cellHeight * _cellWidth / _cellHeight
        }else {
            return frame.width * 0.5 * _cellWidth / frame.width
        }
    }
    
    var cellHeight: CGFloat {
        if frame.width > frame.height {
            return frame.height
        }else {
            return cellWidth * _cellHeight / _cellWidth
        }
    }
    
    private var isInit: Bool = false
    private let column: CGFloat = 3
    private let spacingTolerance: CGFloat = 5
    private let hSpacing: CGFloat = 10
    private let vSpacing: CGFloat = 10
    private let horizontalPadding: CGFloat = 40
    #if DEBUG
    var data = Array<URL>(repeating: URL(string: "https://cdn.europosters.eu/image/1300/posters/jojo-s-bizarre-adventure-stardust-crusaders-i69129.jpg")!, count: 10)
    #else
    var data: [URL] = []
    #endif
    private(set) var collectionView: UICollectionView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView?.removeFromSuperview()
        configureCollection()
    }
    
    func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumInteritemSpacing = hSpacing
        layout.minimumLineSpacing = vSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(UICollectionViewHorizontalCell.self, forCellWithReuseIdentifier: UICollectionViewHorizontalCell.reusedIdentifier)
        collectionView?.backgroundColor = .clear
        collectionView?.dataSource = self
        collectionView?.delegate = self
        addSubview(collectionView!)
//        view.sendSubviewToBack(collectionView)
        collectionView!.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setData(_ data: [URL]) {
        self.data = data
        collectionView?.reloadData()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension UICollectionHorizontalView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewHorizontalCell.reusedIdentifier, for: indexPath) as! UICollectionViewHorizontalCell
        cell.setData(data[indexPath.row])
        return cell
    }
    
}

extension UICollectionHorizontalView: UICollectionViewDelegate {
    
}
