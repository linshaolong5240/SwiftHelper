//
//  SHQRCodeGenerateiew.swift
//  SwiftHelper
//
//  Created by sauron on 2022/12/29.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import SwiftUI
import ProgressHUD

struct SHQRCodeGenerateiew: View {
    @ObservedObject private var helper: PhotoLibraryHelper = PhotoLibraryHelper()
    @State private var message: String = "";
    @State private var cgImage: CGImage? = nil
    
    init() { }
    
    init(message: String) {
        self._message = State(initialValue: message)
    }
    
    var body: some View {
        VStack {
            TextField("Please input message", text: $message)
                .textFieldStyle(.roundedBorder)
            Button {
                generateQRCode()
            } label: {
                Text("Generate")
            }
            #if os(iOS)
            if cgImage != nil {
                Button {
                    guard let image = cgImage else {
                        ProgressHUD.showError("No image")
                        return
                    }
                    helper.saveImage(cgImage: image)
                } label: {
                    Text("Save")
                }
            }
            #endif
            if let image = cgImage {
                Image(crossImage: CrossImage(cgImage: image))
                #if false
                Text("size: \(cgImage.width), \(cgImage.height)")/
                #endif
            } else {
                Text("Generate QRCode  fail")
            }
        }
        .padding(.all)
        .onAppear {
            generateQRCode()
        }
    }
    
    private func generateQRCode() {
        guard message.count > 0 else {
            return
        }
        cgImage = QRCodeHelper.generateQRCode(inputMessage: message, scale: 10)
    }
}

struct SHQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        SHQRCodeGenerateiew(message: "https://www.baidu.com")
    }
}
