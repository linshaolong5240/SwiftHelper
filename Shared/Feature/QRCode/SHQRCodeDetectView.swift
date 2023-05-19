//
//  SHQRCodeDetectView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/12/29.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import SwiftUI
import Photos
import PhotosUI

struct SHQRCodeDetectView: View {
    @State private var crossImage: CrossImage?
    @State private var showImagePicker: Bool = false
    @State private var showAuthorization: Bool = false
    private var phpickerConfiguration: PHPickerConfiguration {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        configuration.selectionLimit = 1
        return configuration
    }
    
    var body: some View {
        VStack {
            SHImagePickerButton(crossImage: $crossImage)
            if let image = crossImage {
                if let cgImage = crossImage?.cgImage,let message = QRCodeHelper.detectQRCode(cgImage: cgImage, accuracy: .low) {
                    Text(message)
                } else {
                    Text("No message")
                }
                Image(crossImage: image)
            }
        }
    }
    
    private func showPicker() {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        guard authorizationStatus != .denied && authorizationStatus != .restricted else {
            showAuthorization = true
            return
        }
        
        if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                showImagePicker = true
            }
        } else {
            showImagePicker = true
        }
    }
}

struct QRCodeDetectView_Previews: PreviewProvider {
    static var previews: some View {
        SHQRCodeDetectView()
    }
}
