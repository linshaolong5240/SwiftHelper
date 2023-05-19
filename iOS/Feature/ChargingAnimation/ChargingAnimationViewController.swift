//
//  ChargingAnimationViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/3/25.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import AVFoundation
import RxSwift
import RxCocoa
import SwiftUI
import SnapKit

extension NSUserActivity {
    public static let chargingAnimationActivityType = "com.teenloong.SwiftHelper.ChargingAnimation"
    public static var chargingAnimationActivity: NSUserActivity {
        let activity = NSUserActivity(activityType: NSUserActivity.chargingAnimationActivityType) // 1
        activity.title = NSLocalizedString("Charging Effects", comment: "") // 2
        activity.userInfo = ["speech" : "hi"] // 3
        activity.isEligibleForSearch = true // 4
        if #available(iOS 12.0, *) {
            activity.isEligibleForPrediction = true
            activity.persistentIdentifier = NSUserActivityPersistentIdentifier(NSUserActivity.chargingAnimationActivityType)
        }
        return activity
    }
}

class ChargingAnimationViewModel {
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

class ChargingAnimationViewController: SHBaseViewController {
    private var viewModel: ChargingAnimationViewModel = ChargingAnimationViewModel()

    private var playerView: SHAVPlayerView!

//    override var shouldAutorotate: Bool { true }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
//
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .portrait
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Charging Animation"
        view.backgroundColor = .orange
        userActivity = .chargingAnimationActivity

        configurePlayerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSupportOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.player.play()
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        coordinator.animate(alongsideTransition: { context in
//            self.playerView.frame.size = size
//            self.playerView.playerLayer.frame.size = size
//        }, completion: nil)
//    }
    
    func configurePlayerView() {
        playerView = SHAVPlayerView()
        playerView.player = viewModel.player
        playerView.playerLayer.videoGravity = .resizeAspectFill
        view.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

#if DEBUG
struct ChargingAnimationViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(
            ChargingAnimationViewController())
        .ignoresSafeArea()
//        .previewInterfaceOrientation(.landscapeLeft)
    }
}
#endif
