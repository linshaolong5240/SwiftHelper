//
//  FileExporterExampleView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/8.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct FileExporterExampleView: View {
    @State private var showExporter = false
    @State private var showMutipleExporter = false
    @State private var showExporterButton = true
    @State private var crossImage: CrossImage = CrossImage(systemName: "swift") ?? CrossImage()
    
    var body: some View {
        VStack {
            Image(crossImage: crossImage)
                .foregroundColor(Color.accentColor)
            Button("Exporter single image") {
                showExporter = true
            }
            .fileExporter(isPresented: $showExporter, document: ImageFileDocument(crossImage: crossImage), contentType: .png) { result in
                switch result {
                case .success(let url):
    #if DEBUG
                    print("fileExporter success: \(url)")
    #endif
    #if canImport(AppKit)
                    NSWorkspace.shared.open(url)
    #endif
                case .failure(let error):
    #if DEBUG
                    print("fileExporter failure: \(error.localizedDescription)")
    #endif
                }
            }
            Button("Exporter Multiple image") {
                showMutipleExporter = true
            }
            .fileExporter(isPresented: $showMutipleExporter, documents: [ImageFileDocument(crossImage: crossImage), ImageFileDocument(crossImage: crossImage)], contentType: .png) { result in
                switch result {
                case .success(let url):
    #if DEBUG
                    print("fileExporter success: \(url)")
    #endif
                case .failure(let error):
    #if DEBUG
                    print("fileExporter failure: \(error.localizedDescription)")
    #endif
                }
            }
            Spacer()
        }

    }
}

struct SwiftUIEvnetFileExporterView_Previews: PreviewProvider {
    static var previews: some View {
        FileExporterExampleView()
    }
}
