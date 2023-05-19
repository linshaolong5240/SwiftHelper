//
//  OnDropExampleView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/18.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers.UTType

struct OnDropExampleView: View {
    @State var cgImage: CGImage? = nil
    @State var cgImages: [CGImage] = []
    var body: some View {
        ScrollView {
            Text("Drop images")
                .font(.largeTitle)
                .frame(width: 200, height: 200)
            if let image = cgImage {
                Image(image, scale: 1.0, label: Text("Image"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
            ForEach(0..<cgImages.count, id: \.self) { index in
                Image(cgImages[index], scale: 1.0, label: Text("Image"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
        }
        .onDrop(of: [.image], delegate: self)
    }
}

struct OnDropExampleView_Previews: PreviewProvider {
    static var previews: some View {
        OnDropExampleView()
    }
}

extension OnDropExampleView: DropDelegate {
    
    func performDrop(info: DropInfo) -> Bool {

        func loadItemDone(item: NSSecureCoding?, error: Error?) {
            guard let url = item as? URL else {
                return
            }
            
            guard let ciImage = CIImage(contentsOf: url) else {
                return
            }
            
            let context = CIContext()
            
            guard let cgImage = context.createCGImage(ciImage, from:ciImage.extent) else {
                return
            }
            DispatchQueue.main.async {
                self.cgImages.append(cgImage)
            }
        }

        let imageItems = info.itemProviders(for: [.image])
        
        if !imageItems.isEmpty {
            DispatchQueue.main.async {
                self.cgImages = []
            }
        }
        
        for item in imageItems {
            item.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil, completionHandler: loadItemDone)
        }
        return true
    }
    
}
