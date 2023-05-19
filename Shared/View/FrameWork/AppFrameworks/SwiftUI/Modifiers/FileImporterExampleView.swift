//
//  FileImporterExampleView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/18.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct FileImporterExampleView: View {
    @State var crossImage: CrossImage?
    @State var crossImages: [CrossImage] = []
    @State var showImageImporter: Bool = false
    @State var showImagesImporter: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Button("Image import") {
                    showImageImporter = true
                }
                .fileImporter(isPresented: $showImageImporter, allowedContentTypes: [.jpeg, .png]) { result in
                    switch result {
                    case .success(let success):
                        self.crossImage = success.image
#if DEBUG
                        print(success)
#endif
                    case .failure(let failure):
#if DEBUG
                        print(failure)
#endif
                    }
                }
                if let image = crossImage {
                    Image(crossImage: image)
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
                Divider()
                Button("Images import") {
                    showImagesImporter = true
                }
                .fileImporter(isPresented: $showImagesImporter, allowedContentTypes: [.jpeg, .png], allowsMultipleSelection: true) { result in
                    switch result {
                    case .success(let success):
                        self.crossImages = success.compactMap(\.image)
#if DEBUG
                        print(success)
#endif
                    case .failure(let failure):
#if DEBUG
                        print(failure)
#endif
                    }
                }
                ForEach(0..<crossImages.count, id: \.self) { index in
                    Image(crossImage: crossImages[index])
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
            }
            .padding()
        }
    }
}

struct FileImporterExampleView_Previews: PreviewProvider {
    static var previews: some View {
        FileImporterExampleView()
    }
}
