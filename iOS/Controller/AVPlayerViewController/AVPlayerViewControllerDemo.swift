//
//  AVPlayerViewControllerDemo.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/5/13.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import AVKit
import RxSwift
import RxCocoa

class AVPlayerViewControllerDemo: SHBaseViewController {
    var disposeBag = DisposeBag()
    private let playerControll = AVPlayerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = Bundle.main.url(forResource: "charging_animation_vedio", withExtension: "mp4")!
        let palyer = AVPlayer(url: url)
        playerControll.player = palyer
        view.addSubview(playerControll.view)
        playerControll.view.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.width / 16 * 9)
        }
        
        NotificationCenter.default.rx.notification(.AVPlayerItemDidPlayToEndTime).subscribe(with: self) { owner, notification in
            owner.playerControll.player?.seek(to: .zero)
            owner.playerControll.player?.play()
        }.disposed(by: disposeBag)
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
struct AVPlayerViewControllerDemo_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(
            AVPlayerViewControllerDemo())
//        .previewInterfaceOrientation(.landscapeLeft)
    }
}
#endif
