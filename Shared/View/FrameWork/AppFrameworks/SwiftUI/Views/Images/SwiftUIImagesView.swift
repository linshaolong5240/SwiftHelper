//
//  SwiftUIImagesView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/2/21.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUIImagesView: View {
    let urlString: String = "https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png"
    
    var body: some View {
        ScrollView {
            Text("AsyncImage")
            AsyncImage(url: URL(string: urlString)!, scale: 1.0) {
                phase in
                switch phase{
                case .empty:
                    Color.blue
                case .success(let image):
                    image
                case .failure(let error):
                    Text("\(error.localizedDescription)")
                @unknown default:
                    fatalError()
                }
            }
            Divider()
            Text("ImageRenderer")
            ImageRendererView()
        }
    }
}

struct SwiftUIImagesView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIImagesView()
    }
}
