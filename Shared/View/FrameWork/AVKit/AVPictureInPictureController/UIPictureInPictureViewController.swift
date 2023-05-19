//
//  UIPictureInPictureViewController.swift
//  SwiftHelper
//
//  Created by sauron on 2022/5/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//
import SwiftUI
import AVKit
import SnapKit

class UIPictureInPictureViewController: UIViewController {
    private var viewModel: PictureInPictureViewModel = PictureInPictureViewModel()

    private var playerView: SHAVPlayerView!
    private var pipController: AVPictureInPictureController!
    //设置开启或者关闭pictureInPicture
    let pipButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Picture In Picture"
        view.backgroundColor = .orange
        userActivity = .chargingAnimationActivity

        configurePlayerView()
        configurePIPButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    func configurePlayerView() {
        playerView = SHAVPlayerView()
        playerView.player = viewModel.player
        playerView.playerLayer.videoGravity = .resizeAspect
        playerView.backgroundColor = .systemPink
        view.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.width / 16 * 9)
        }
        
        if AVPictureInPictureController.isPictureInPictureSupported() == true {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                try AVAudioSession.sharedInstance().setActive(true, options: [])
            } catch {
                print("AVAudioSession发生错误")
            }
            pipController = AVPictureInPictureController(playerLayer: playerView.playerLayer) // playerLayer为播放器的图层，不能为新建的AVPlayerLayer
            if #available(iOS 14.2, *) {
                pipController.canStartPictureInPictureAutomaticallyFromInline = true //应用进入后台自动开启PIP
            } else {
                // Fallback on earlier versions
            }
            pipController.delegate = self // 成为代理
        }
    }
    
    func configurePIPButton() {
        //系统默认的pictureInPictureButtonStartImage
        let startImage = AVPictureInPictureController.pictureInPictureButtonStartImage
        pipButton.setImage(startImage, for: .normal)
        pipButton.frame = CGRect(x: 10, y: 20, width: 40, height: 40)
        pipButton.addTarget(self, action: #selector(clickPipButton(_:)), for: .touchUpInside)
        view.addSubview(pipButton)
    }

    
    @objc func clickPipButton(_ sender: Any) {
        if viewModel.player.rate == 0 {
            viewModel.player.play()
        }

        if pipController.isPictureInPicturePossible {
            print("画中画目前不可用")
        } else {
            print("画中画目前可用")
        }
        //判断Pip是否在Active状态
        let isActive = pipController.isPictureInPictureActive
        if (isActive) {
           //停止画中画
            pipController.stopPictureInPicture()
            let startImage = AVPictureInPictureController.pictureInPictureButtonStartImage
            pipButton.setImage(startImage, for: .normal)
        } else {
            //启动画中画
            //必须通过按钮调用
            pipController.startPictureInPicture()
            //系统默认的pictureInPictureButtonStopImage
            let stopImage = AVPictureInPictureController.pictureInPictureButtonStopImage
            pipButton.setImage(stopImage, for: .normal)
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

struct AVPictureInPictureControllerDemo_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(
            UIPictureInPictureViewController())
        .ignoresSafeArea()
//        .previewInterfaceOrientation(.landscapeLeft)
    }
}

extension UIPictureInPictureViewController: AVPictureInPictureControllerDelegate {
    func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("将要开始PictureInPicture的代理方法")
    }

    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("已经开始PictureInPicture的代理方法")
    }

   
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        print("启动PictureInPicture失败的代理方法")
    }

    
    func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("将要停止PictureInPicture的代理方法")
    }

    
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("已经停止PictureInPicture的代理方法")
    }

    
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        //此方法执行在pictureInPictureControllerWillStopPictureInPicture代理方法之后，在pictureInPictureControllerDidStopPictureInPicture执行之前。 但是点击“X”移除画中画时，不执行此方法。
        print("PictureInPicture停止之前恢复用户界面")
    }
}
