//
//  ImageRendererView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/17.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct ImageRendererView: View {
    var body: some View {
        let trophyAndDate = createAwardView(forUser: "playerName",
                                            date: Date.now)
        VStack {
            trophyAndDate
            Button("Save to download directory") {
                let renderer = ImageRenderer(content: trophyAndDate)
                if let cgImage = renderer.cgImage , let url = FileManager.default.downloadDirectory?.appending(path: "ImageRenderer\(Date.now.formatString("yyyyMMddHHmmss")).png") {
                    cgImage.save(to: url, format: .png)
                }
            }
        }
    }
}

struct ImageRendererView_Previews: PreviewProvider {
    static var previews: some View {
        ImageRendererView()
    }
}

private func createAwardView(forUser: String, date: Date) -> some View {
    VStack {
        Image(systemName: "trophy")
            .resizable()
            .frame(width: 200, height: 200)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .shadow(color: .mint, radius: 5)
        Text(forUser)
            .font(.largeTitle)
        Text(date.formatted())
    }
    .multilineTextAlignment(.center)
    .background(Color.accentColor)
    .mask {
        RoundedRectangle(cornerRadius: 49, style: .continuous)
    }
    .frame(width: 290, height: 290)
}
