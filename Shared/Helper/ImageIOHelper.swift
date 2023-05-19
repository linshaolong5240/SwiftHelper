//
//  ImageIOHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/15.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Foundation
import CoreImage
import UniformTypeIdentifiers

extension CGImage {
    @discardableResult
    public func save(to url: URL, format type: UniformTypeIdentifiers.UTType) -> Bool {
        guard let cgImageDestination = CGImageDestinationCreateWithURL(url as CFURL, type.description as CFString, 1, nil) else {
#if DEBUG
            print("Image I/O: CGImageDestinationCreateWithURL Failed")
#endif
            return false
        }
        CGImageDestinationAddImage(cgImageDestination, self, nil)
        let result = CGImageDestinationFinalize(cgImageDestination)
#if DEBUG
        print("Image I/O: save CGImage to \(url) \(result ? "Succeed" : "Failed")")
#endif
        return result
    }
    
    @discardableResult
    public func makeData(to type: UniformTypeIdentifiers.UTType) -> Data? {
        guard let data = CFDataCreateMutable(nil, 0) else {
#if DEBUG
            print("Image I/O: CFDataCreateMutable Failed")
#endif
            return nil
        }
        guard let cgImageDestination = CGImageDestinationCreateWithData(data, type.description as CFString, 1, nil) else {
#if DEBUG
            print("Image I/O: CGImageDestinationCreateWithData Failed")
#endif
            return nil
        }
        CGImageDestinationAddImage(cgImageDestination, self, nil)
        let result = CGImageDestinationFinalize(cgImageDestination)
#if DEBUG
        print("Image I/O: convert CGImage to data \(result ? "Succeed" : "Failed")")
#endif
        return data as Data
    }
}

