//
//  WidgetTransparentBackgroundSettingView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/9.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import Combine
import PhotosUI

struct WidgetTransparentBackgroundSettingView: View {
    @EnvironmentObject private var store: Store
    var screenshot: SHWidgetTransparentConfiguration { store.appState.widget.transparentCondiguration }
    var screenSize: CGSize {
        CGSize(width: UIScreen.main.bounds.size.width * 0.3, height: UIScreen.main.bounds.size.height * 0.3)
    }
    
    @State private var colorScheme: ColorScheme = .light
    @State private var uiImage: UIImage?
    @State private var showImagePicker: Bool = false
    @State private var showAuthorization: Bool = false
    @State private var enableDarkMode: Bool = true

    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Color.pink
                    if let image = screenshot.lightImage {
                        Image(uiImage: image)
                            .resizable()
                    }
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .frame(width: screenSize.width, height: screenSize.height)
                .onTapGesture {
                    colorScheme = .light
                    showImagePicker.toggle()
                }
                if enableDarkMode {
                    ZStack {
                        Color.pink
                        if let image = screenshot.darkImage {
                            Image(uiImage: image)
                                .resizable()
                        }
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .frame(width: screenSize.width, height: screenSize.height)
                    .onTapGesture {
                        colorScheme = .dark
                        showImagePicker.toggle()
                    }
                }
            }
            
            Toggle(isOn: $enableDarkMode) {
                Text("Enable Dark Mode")
            }

            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAuthorization, content: { .photoLibraryAuthorization })
        .fullScreenCover(isPresented: $showImagePicker) {
            SHImagePicker(uiimage: $uiImage)
        }
        .onChange(of: uiImage) { newValue in
            guard let image = newValue else { return }
            do {
                if let imageURL = try FileManager.save(image: image) {
                    store.dispatch(.setWidgetTransparentBackground(imageURL: imageURL, colorScheme: colorScheme))
//                    selection = .init(imagePath: imageURL.path)
#if DEBUG
                    print(imageURL)
#endif
                }
            } catch let error {
#if DEBUG
                print(error)
#endif
            }
        }
    }
    
    func showPicker() {
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

struct WidgetTransparentbackgroundSettingView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetTransparentBackgroundSettingView()
            .environmentObject(Store.shared)
    }
}
