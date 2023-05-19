//
//  PhotosPickerView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/3/15.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import PhotosUI

struct PhotosPickerView: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State var selectedImageDatas: [Data?] = []
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItems,
                         matching: .images) {
                Text("Select Multiple Photos")
            }
            let columns: [GridItem] = [GridItem.init(), GridItem.init(), GridItem.init()]
            LazyVGrid(columns: columns) {
                ForEach(selectedImageDatas, id: \.self) { item in
                    if let data = item {
#if canImport(AppKit)
                        if let nsImage = NSImage(data: data) {
                            Image(nsImage: nsImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
#endif
#if canImport(UIKit)
                        if let uiIamge = UIImage(data: data) {
                            Image(uiImage: uiIamge)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
#endif
                    } else {
                        Text("nil")
                    }
                }
            }
            Spacer()
        }
        .onChange(of: selectedItems) { newValue in
            //https://developer.apple.com/forums/thread/709764?answerId=719540022#719540022
            Task {
                var datas: [Data?] = []
                for value in newValue {
                    let data = try await value.loadTransferable(type: Data.self)
                    datas.append(data)
                }
                selectedImageDatas = datas
            }
        }
    }
}

struct PhotosPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosPickerView()
    }
}
