//
//  AVPlayerViewDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/6/20.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit
import Combine
import AVFoundation

class AVPlayerViewDemoController: SHBaseViewController {
    var cancells = Set<AnyCancellable>()
    private var avPlayerView: SHAVPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureAVPlayerView()
    }
    
    private func configureAVPlayerView() {
        avPlayerView = SHAVPlayerView(frame: .zero)
        let url = Bundle.main.url(forResource: "charging_animation_vedio", withExtension: "mp4")!
        avPlayerView.player = AVPlayer(url: url)
        avPlayerView.player?.actionAtItemEnd = .none
        avPlayerView.player?.play()
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime).sink { completion in
            
        } receiveValue: {[weak self] notification in
            self?.avPlayerView.player?.seek(to: .zero)
            
        }.store(in: &cancells)

        view.addSubview(avPlayerView)
        avPlayerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 300))
        }
    }
}

#if DEBUG
struct AVPlayerViewDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(AVPlayerViewDemoController()).ignoresSafeArea()
    }
}
#endif
