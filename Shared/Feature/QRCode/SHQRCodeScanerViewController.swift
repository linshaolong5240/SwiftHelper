//
//  SHQRCodeScanerViewController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/12/29.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import SnapKit
import ProgressHUD

protocol SHQRCodeScannerViewControllerDelegate: AnyObject {
    func qrCodeScanerViewController(qrCodeScanerViewController: SHQRCodeScanerViewController, didDetect message:String)
}

class SHQRCodeScanerViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    weak var delegate: SHQRCodeScannerViewControllerDelegate?
    
    var isInit: Bool = false

    var captureSession: AVCaptureSession!
    
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    private(set) var authorizationStatus: AVAuthorizationStatus = .notDetermined
    
    private var captureHelper: AVCaptureHelper = AVCaptureHelper()
    
    private var tempNavigationBarHidden: Bool = false
    
    private var flashlightButton: UIButton!
    
    private var canUsePhotoLibrary: Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        return !(status == .denied || status == .restricted)
    }
    
    private lazy var scanLine = UIImageView(image: UIImage(named: "ScannerScanLine"))
    
    private var isAnimationing = false
    
    //    private var captureSession: AVCaptureSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "QR Code Scaner"
        view.backgroundColor = .black
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tempNavigationBarHidden = navigationController?.isNavigationBarHidden ?? false
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(tempNavigationBarHidden, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAuthorizationStatus()
        startCapture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopCapture()
    }
    
    private func configureView() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonOnClicked), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).inset(20)
        }
        
        let flashlightButton = UIButton(type: .custom)
        flashlightButton.isEnabled = false;
        flashlightButton.setImage(UIImage(systemName: "flashlight.off.fill"), for: .normal)
        flashlightButton.setImage(UIImage(systemName: "flashlight.on.fill"), for: .selected)
        flashlightButton.addTarget(self, action: #selector(flashlightButtonOnClicked), for: .touchUpInside)
        view.addSubview(flashlightButton)
        flashlightButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.left.equalTo(view).inset(56)
        }
        self.flashlightButton = flashlightButton
        
        let albumButton = UIButton(type: .custom)
        albumButton.setImage(UIImage(systemName: "photo"), for: .normal)
        albumButton.addTarget(self, action: #selector(albumButtonOnClicked), for: .touchUpInside)
        view.addSubview(albumButton)
        albumButton.snp.makeConstraints { make in
            make.bottom.equalTo(flashlightButton)
            make.right.equalTo(view).inset(56)
        }
    }
    
    @objc private func backButtonOnClicked() {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        }else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func flashlightButtonOnClicked(_ sender: UIButton) {
        guard let device = AVCaptureDevice.default(for: .video) else {
            sender.isEnabled = false
            return
        }
        
        let lightOn = device.torchMode == .on
        do {
            try device.lockForConfiguration()
        } catch {
            return
        }
        device.torchMode = lightOn ? .off : .on
        sender.isSelected = lightOn ? false: true
        device.unlockForConfiguration()
    }
    
    @objc private func albumButtonOnClicked() {
        if canUsePhotoLibrary {
            let picture = UIImagePickerController()
            picture.sourceType = .photoLibrary
            picture.delegate = self
            self.present(picture, animated: true, completion: nil)
        } else {
            //            NCWThemeViewModel.showAlbumAlert(self)
        }
    }
    
    private func configureCapture() {
        guard !isInit else {
            return
        }
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            showFailAlert()
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch let error {
            ProgressHUD.showError("\(error)")
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            showFailAlert()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            showFailAlert()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(previewLayer, at: 0)
        startCapture()
        isInit = true
    }
    
    private func startCapture() {
        if (captureSession?.isRunning == false) {
            DispatchQueue.global().async { [weak self] in
                self?.captureSession.startRunning()
            }
        }
    }
    
    private func stopCapture() {
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    private func showFailAlert() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    private func showPermissonAlert() {
        let ac = UIAlertController(title: "Camera Permisson", message: "Go to setting.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Go", style: .default, handler: { action in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                // Ask the system to open that URL.
                UIApplication.shared.open(url)
            }
        }))
        present(ac, animated: true)
        captureSession = nil
    }
    
    private func configureCaptureError(error: Error) {
        ProgressHUD.showError("\(error)")
    }
    
    private func checkAuthorizationStatus() {
        self.authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch self.authorizationStatus {
        case .notDetermined:
            requestAcess()
            break
        case .restricted, .denied:
            showPermissonAlert()
            break
        case .authorized:
            configureCapture()
            break
        @unknown default:
            fatalError("Unknown AVAuthorizationStatus: \(self.authorizationStatus)")
        }
    }
    
    private func requestAcess() {
        AVCaptureDevice.requestAccess(for: .video) { status in
            DispatchQueue.main.async {
                self.requestAcessDone(status: status)
            }
        }
    }
    
    private func requestAcessDone(status: Bool) {
        checkAuthorizationStatus()
    }
}

extension SHQRCodeScanerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let message = readableObject.stringValue else { return }
#if DEBUG
            print("found message:\(message)")
#endif
            //            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            ProgressHUD.showSucceed(message)
            self.delegate?.qrCodeScanerViewController(qrCodeScanerViewController: self, didDetect: message)
        }
    }
}

extension SHQRCodeScanerViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage, let cgImage = image.cgImage, let message = QRCodeHelper.detectQRCode(cgImage: cgImage, accuracy: .low) {
            delegate?.qrCodeScanerViewController(qrCodeScanerViewController: self, didDetect: message)
            ProgressHUD.showSucceed(message)
        } else {
            ProgressHUD.showSucceed("Not found")
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
