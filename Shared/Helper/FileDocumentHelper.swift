//
//  FileExportHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2022/4/30.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers.UTType

struct ImageFileDocument: FileDocument {

    static var readableContentTypes: [UTType] { [.jpeg, .png] }
    
    static var writableContentTypes: [UTType] { [.jpeg, .png] }

    var data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    init(cgImage: CGImage, type: UTType) {
        self.data = cgImage.makeData(to: type) ?? Data()
    }
    
    init(crossImage: CrossImage) {
        self.data = crossImage.cgImage?.makeData(to: .png) ?? Data()
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.data = data
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: self.data)
    }
}
