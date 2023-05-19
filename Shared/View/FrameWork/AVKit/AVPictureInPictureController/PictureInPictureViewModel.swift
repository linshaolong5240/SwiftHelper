//
//  PictureInPictureViewModel.swift
//  SwiftHelper
//
//  Created by sauron on 2022/12/29.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import Foundation
import AVFoundation
import RxSwift

class PictureInPictureViewModel {
    var disposeBag = DisposeBag()
    var player: AVPlayer
    
    init() {
        let url = Bundle.main.url(forResource: "charging_animation_vedio", withExtension: "mp4")!
        let avPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: avPlayerItem)
        player.actionAtItemEnd = .none
        player.volume = 0
        NotificationCenter.default.rx.notification(.AVPlayerItemDidPlayToEndTime).subscribe(with: self) { owner, notification in
            owner.player.currentItem?.seek(to: .zero, completionHandler: nil)
        }.disposed(by: disposeBag)
    }
}
