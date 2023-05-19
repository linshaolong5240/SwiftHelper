//
//  SHImageCollectionView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2023/2/11.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import SnapKit

class SHImageCollectionView: UIView {
    
    private var images: [UIImage] = [
        UIImage(systemName: "circle.fill")!,
        UIImage(systemName: "square.fill")!,
        UIImage(systemName: "triangle.fill")!,
        UIImage(systemName: "diamond.fill")!,
        UIImage(systemName: "octagon.fill")!,
        UIImage(systemName: "plus")!,
    ]
    
    private var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        let columns: CGFloat = 3
        let padding: CGFloat = 10
        let paddingWidth = (columns - 1) * padding
        let width = (UIScreen.main.bounds.width - paddingWidth) / columns
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = padding
        layout.itemSize = .init(width: width, height: 100)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SHImageCollectionViewCell.self, forCellWithReuseIdentifier: SHImageCollectionViewCell.reusedIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressGestur)))
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func longPressGestur(gesture: UIGestureRecognizer) {
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

#if DEBUG
struct SHImageCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewRepresent(SHImageCollectionView()).ignoresSafeArea()
    }
}
#endif

extension SHImageCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SHImageCollectionViewCell.reusedIdentifier, for: indexPath) as! SHImageCollectionViewCell
        cell.imageView.image = self.images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        indexPath.item != self.images.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("Start index: \(sourceIndexPath.item)")
        print("End index: \(destinationIndexPath.item)")
        let startIndex = sourceIndexPath.item
        let endIndex = destinationIndexPath.item == (self.images.count - 1) ? (destinationIndexPath.item - 1) : destinationIndexPath.item
        guard startIndex != endIndex else {
            return
        }
        let tmp = self.images[startIndex]
        self.images.remove(at: startIndex)
        self.images.insert(tmp, at: endIndex)
        self.collectionView.reloadData()
    }
}

extension SHImageCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        #if DEBUG
        print("\(#function) \(indexPath)")
        #endif
        if (indexPath.row == self.images.count - 1) {
            
        }
    }
}
