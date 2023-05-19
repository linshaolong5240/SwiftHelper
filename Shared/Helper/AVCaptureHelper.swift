//
//  AVCaptureHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2022/12/29.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import Foundation
import Combine
import AVFoundation

public class AVCaptureHelper: ObservableObject {
    
    @Published public private(set) var authorization: AVAuthorizationStatus = .notDetermined
    
    @Published public private(set) var isAuthorizationed: Bool = false
    
    public init() {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        self.authorization = authorizationStatus
        self.isAuthorizationed = authorizationStatus == .authorized
    }
    
    public func checkAuthorizationStatus() {
        authorization = AVCaptureDevice.authorizationStatus(for: .video)
        switch authorization {
        case .notDetermined:
            requestAcess()
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            break
        @unknown default:
            fatalError("Unknown AVAuthorizationStatus !")
        }
    }
    
    private func requestAcess() {
        AVCaptureDevice.requestAccess(for: .video) { status in
            self.requestAcessDone(status: status)
        }
    }
    
    private func requestAcessDone(status: Bool) {
        checkAuthorizationStatus()
    }
}
