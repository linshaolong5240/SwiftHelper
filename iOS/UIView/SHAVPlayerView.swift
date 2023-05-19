//
//  SHAVPlayerView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/3/25.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import AVFoundation

class SHAVPlayerView: UIView {
    // Override the property to make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    // The associated player object.
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

#if DEBUG
struct SHAVPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let v: SHAVPlayerView = {
            let v = SHAVPlayerView()
            let url = Bundle.main.url(forResource: "charging_animation_vedio", withExtension: "mp4")!
            v.player = AVPlayer(url: url)
            v.player?.actionAtItemEnd = .none
            v.player?.play()
            return v
        }()
        
        PlatformViewRepresent(v).ignoresSafeArea()
    }
}
#endif
