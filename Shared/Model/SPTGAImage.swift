//
//  SPTGAImage.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/13.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Foundation
import SPImage

public struct SPTGAImage {
    private(set) var width: Int
    private(set) var height: Int
    private(set) var bitsPerPixel: Int
    public var bytesPerPixel: Int { bitsPerPixel / 8 }
    public var bytesPerRow: Int { bytesPerPixel * width }
    
    private(set) var data: Data
    
    init?(contentsOfFile url: URL) {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        var header = SPTGAHeader()
        data.withUnsafeBytes { rawBufferPointer in
            let mutableRawPointer = UnsafeMutableRawPointer(mutating: rawBufferPointer.baseAddress)
            header = MakeTGAHeader(mutableRawPointer)
        }
#if DEBUG
        print("TGA image width: \(header.width), height: \(header.height), bitsPerAlpha: \(header.descriptor.bitsPerAlpha) rightOrigin: \(header.descriptor.rightOrigin) topOrigin: \(header.descriptor.topOrigin)")
#endif
        let bytesPerPixel: Int = Int(header.bitsPerPixel / 8)
        let bytesPerRow: Int = bytesPerPixel * Int(header.width)
        
        let imageDataBytesCount: Int = Int(header.width) * Int(header.height) * 4
        let imageDataIndex: Int = data.startIndex + MemoryLayout<SPTGAHeader>.size + Int(header.idLength)
        let srcData = data.subdata(in: imageDataIndex..<(imageDataIndex + imageDataBytesCount))
        var dstData = Data(repeating: 0, count: bytesPerRow * Int(header.height))
        for y in 0..<Int(header.height) {
            let srcRow: Int = header.descriptor.topOrigin > 0 ? Int(header.height - 1) - y : y
            for x in 0..<Int(header.width) {
                let srcColumn: Int = header.descriptor.rightOrigin > 0 ? Int(header.width - 1) - x : x
                let dstPixIndex: Int = y * bytesPerRow + bytesPerPixel * srcColumn
                let srcPixIndex: Int = srcRow * bytesPerRow + x * bytesPerPixel
                dstData[dstPixIndex] = srcData[srcPixIndex]
                dstData[dstPixIndex + 1] = srcData[srcPixIndex + 1]
                dstData[dstPixIndex + 2] = srcData[srcPixIndex + 2]
            }
        }
        
        self.width = Int(header.width)
        self.height = Int(header.height)
        self.bitsPerPixel = Int(header.bitsPerPixel)
        self.data = dstData
    }
    
}
