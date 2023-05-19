//
//  SHWidgetGifModelEditer.swift
//  SwiftHelper
//
//  Created by sauron on 2022/5/7.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import WidgetKit

struct SHWidgetGifModelEditer: View {
    @Binding var gifModel: SHGifWidgetConfiguration.GifModel
    let family: WidgetFamily
    
    @State private var uiImage: CrossImage?
    @State private var showImagePicker: Bool = false
    @State private var showAuthorization: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("Select Photo")
            HStack {
                Button {
                    showImagePicker.toggle()
                } label: {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 44, height: 44)
                }
                ForEach(Array(gifModel.imagesURL.enumerated()), id: \.offset) { index, item in
                    if let image = item.image {
                        Image(crossImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                gifModel.imagesURL.remove(at: index)
                            }
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal)
        .alert(isPresented: $showAuthorization, content: { .photoLibraryAuthorization })
#if canImport(UIKit)
        .fullScreenCover(isPresented: $showImagePicker) {
            SHImagePicker(uiimage: $uiImage)
        }
#endif
        .onChange(of: uiImage) { newValue in
            guard let image = newValue else { return }
            guard let resizeImage = image.crop(ratio: family.ratio)?.resize(to: CGSize(width: family.miniSize.width * 0.45, height: family.miniSize.height * 0.45)) else {
                return 
            }
            do {
                if let imageURL = try FileManager.save(image: resizeImage) {
                    gifModel.imagesURL.append(imageURL)
#if DEBUG
                    let data = imageURL.image!.pngData()!
                    let bcf = ByteCountFormatter()
                    bcf.allowedUnits = [.useKB] // optional: restricts the units to MB only
                    bcf.countStyle = .file
                    let size = bcf.string(fromByteCount: Int64(data.count))
                    print("image size: \(size)")
#endif
                }
            }catch let error {
#if DEBUG
                print(error)
#endif
            }
    }
    }
}

struct SHWidgetGifModelEditer_Previews: PreviewProvider {
    static var previews: some View {
        SHWidgetGifModelEditer(gifModel: .constant(.init()), family: .systemSmall)
    }
}
