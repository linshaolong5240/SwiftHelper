//
//  PhotoLibraryHelper.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/12/29.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import Foundation
import Combine
import Photos
import UIKit

public class PhotoLibraryHelper: NSObject, ObservableObject {
    @Published private(set) var authorizationStatus: PHAuthorizationStatus
    @Published private(set) var isAuthorizationed: Bool = false
    @Published private(set) var showAuthorization = false
    
    override init() {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        self.authorizationStatus = authorizationStatus
        self.isAuthorizationed = authorizationStatus == .authorized || authorizationStatus == .limited
        self.showAuthorization = authorizationStatus == .restricted || authorizationStatus == .denied
        super.init()
    }
    
    public func checkAuthorizationStatus() {
        authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case .notDetermined:
            requestAcess()
        case .restricted, .denied:
            showAuthorization = true;
        case .authorized, .limited:
            showAuthorization = false;
        @unknown default:
            fatalError("Unknown PHPhotoLibrary AuthorizationStatus")
        }
    }
    
    private func requestAcess() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            self.requestAcessDone(status: status)
        }
    }
    
    private func requestAcessDone(status: PHAuthorizationStatus) {
        authorizationStatus = status
        isAuthorizationed = status == .authorized || status == .limited
        checkAuthorizationStatus()
    }
    
    public func saveImage(cgImage: CGImage) {
        saveImage(crossImage: CrossImage(cgImage: cgImage))
    }
    
    public func saveImage(crossImage: CrossImage) {
        guard isAuthorizationed else {
            checkAuthorizationStatus()
            return
        }
        UIImageWriteToSavedPhotosAlbum(crossImage, self, #selector(saveImageCompleted), nil)
    }
    
    @objc private func saveImageCompleted(image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        guard error == nil else {
#if DEBUG
            print("Save image error:\(error!)")
#endif
            return
        }
        #if DEBUG
        print("Save image completed")
        #endif
    }
}
