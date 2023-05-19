//
//  SPAppIconGenerater.swift
//  SwiftHelper
//
//  Created by sauron on 2023/4/28.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CoreImage
import CoreGraphics
import UniformTypeIdentifiers

public enum SPAppIconPlatform: String, CaseIterable {
    case iOS, macOS
}

public struct SPAppIcon: Identifiable {
    public var id: String { outputFilename }
    public var platform: SPAppIconPlatform
    public var scale: CGFloat
    public var point: CGFloat
    public var width: CGFloat { point }
    public var height: CGFloat { point }
    public var pixWidth: CGFloat { point * scale }
    public var pixHeight: CGFloat { point * scale }
    public var cgImage: CGImage?
    
    public var outputFilename: String { "AppIcon-\(platform)-\(Int(width).description)x\(Int(height).description)@\(Int(scale))x.png" }

    public static let iOSIcons: [SPAppIcon] = [
        SPAppIcon(platform: .iOS, scale: 1, point: 20),
        SPAppIcon(platform: .iOS, scale: 2, point: 20),
        SPAppIcon(platform: .iOS, scale: 3, point: 20),
        SPAppIcon(platform: .iOS, scale: 1, point: 29),
        SPAppIcon(platform: .iOS, scale: 2, point: 29),
        SPAppIcon(platform: .iOS, scale: 3, point: 29),
        SPAppIcon(platform: .iOS, scale: 1, point: 40),
        SPAppIcon(platform: .iOS, scale: 2, point: 40),
        SPAppIcon(platform: .iOS, scale: 3, point: 40),
        
        /// iphone App Icon
        SPAppIcon(platform: .iOS, scale: 1, point: 60),
        SPAppIcon(platform: .iOS, scale: 2, point: 60),
        SPAppIcon(platform: .iOS, scale: 3, point: 60),
        
        /// iPad App Icon
        SPAppIcon(platform: .iOS, scale: 1, point: 76),
        SPAppIcon(platform: .iOS, scale: 2, point: 76),
        
        /// iPad Pro App Icon
        SPAppIcon(platform: .iOS, scale: 1, point: 83.5),
        SPAppIcon(platform: .iOS, scale: 2, point: 83.5),
        
        /// App Store
        SPAppIcon(platform: .iOS, scale: 1, point: 1024),
    ]

    public static let macOSIcons: [SPAppIcon] = [
        SPAppIcon(platform: .macOS, scale: 1, point: 16),
        SPAppIcon(platform: .macOS, scale: 2, point: 16),
        SPAppIcon(platform: .macOS, scale: 1, point: 32),
        SPAppIcon(platform: .macOS, scale: 2, point: 32),
        SPAppIcon(platform: .macOS, scale: 1, point: 128),
        SPAppIcon(platform: .macOS, scale: 2, point: 128),
        SPAppIcon(platform: .macOS, scale: 1, point: 256),
        SPAppIcon(platform: .macOS, scale: 2, point: 256),
        SPAppIcon(platform: .macOS, scale: 1, point: 512),
        SPAppIcon(platform: .macOS, scale: 2, point: 512),
    ]
}

public struct SPOutputAppIcon {
    public var iOSIcons: [SPAppIcon] = []
    public var macOSIcons: [SPAppIcon] = []
}

public class SPAppIconGenerater: ObservableObject {
    @Published public var supportIOS: Bool = true
    @Published public var supportMacOS: Bool = true
    
    @Published public var inputCGImage: CGImage?
    @Published public var inputiOSCGImage: CGImage?
    @Published public var inputMacOSCGImage: CGImage?
    
    @Published public var imageContentMode: ContentMode = .fit
    @Published public var imageBackgroundColor: Color = .white
    
    @Published private(set) var outputIcon: SPOutputAppIcon = SPOutputAppIcon()
    private(set) var outputCGImages: [CGImage] = []

    /// Resize image to 832 * 832 content size in 1024 * 1024 canvas size for macOS app icon
    @Published public var resizeIconForMacOS: Bool = true
    
    //    init() {
    //        #if DEBUG
    //        print("\(Self.self) init")
    //        #endif
    //    }

    @MainActor public func generateIcon() {
        guard let cgImage = inputCGImage else {
            return
        }
        generateIcon(cgImage: cgImage)
    }
    
    @MainActor private func generateIcon(cgImage: CGImage) {
        var appIcon = SPOutputAppIcon()
        if supportIOS {
            let imageView = Image(cgImage, scale: 1.0, label: Text("App Icon"))
                .resizable()
                .aspectRatio(contentMode: imageContentMode)
                .frame(width: 1024, height: 1024)
                .background(imageBackgroundColor)
            guard let cgImage = ImageRenderer(content: imageView).cgImage else {
#if DEBUG
                print("ImageRenderer failed")
#endif
                return
            }
            inputiOSCGImage = cgImage
            appIcon.iOSIcons = generateAppIcon(cgImage: cgImage, icons: SPAppIcon.iOSIcons)
        }
        
        if supportMacOS {
            if resizeIconForMacOS {
                let imageView = Image(cgImage, scale: 1.0, label: Text("App Icon"))
                    .resizable()
                    .aspectRatio(contentMode: imageContentMode)
                    .frame(width: 832, height: 832)
                    .background(imageBackgroundColor)
                    .mask { RoundedRectangle(cornerRadius: 131, style: .continuous) }
                    .frame(width: 1024, height: 1024)
                
                guard let cgImage = ImageRenderer(content: imageView).cgImage else {
    #if DEBUG
                    print("ImageRenderer failed")
    #endif
                    return
                }
                inputMacOSCGImage = cgImage
                appIcon.macOSIcons = generateAppIcon(cgImage: cgImage, icons: SPAppIcon.macOSIcons)
            } else {
                let imageView = Image(cgImage, scale: 1.0, label: Text("App Icon"))
                    .resizable()
                    .aspectRatio(contentMode: imageContentMode)
                    .frame(width: 1024, height: 1024)
                    .background(imageBackgroundColor)
                    .mask { RoundedRectangle(cornerRadius: 179, style: .continuous) }
                
                guard let cgImage = ImageRenderer(content: imageView).cgImage else {
    #if DEBUG
                    print("ImageRenderer failed")
    #endif
                    return
                }
                inputMacOSCGImage = cgImage
                appIcon.macOSIcons = generateAppIcon(cgImage: cgImage, icons: SPAppIcon.macOSIcons)
            }
        }
        outputIcon = appIcon
        outputCGImages = appIcon.iOSIcons.compactMap(\.cgImage) + appIcon.macOSIcons.compactMap(\.cgImage)
    }
    
    private func generateAppIcon(cgImage: CGImage, icons: [SPAppIcon]) -> [SPAppIcon] {
        icons.compactMap { item in
            var temp = item
            let cgImage = cgImage.resize(to: CGSize(width: item.width * item.scale, height: item.height * item.scale))
            temp.cgImage = cgImage
            return temp
        }
    }
    
    public func save(to directory: URL) {
        
        func save(to directory: URL, icons: [SPAppIcon]) {
            for item in icons {
                let outputImageFileURL = directory.appendingPathComponent("/\(item.outputFilename)")
                guard let cgImage = item.cgImage else {
                    return
                }
                cgImage.save(to: outputImageFileURL, format: .png)
            }
        }
        
//        let defaultURL = try? FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let outputDirectoryURL = directory.appendingPathComponent("/AppIcon\(Date.now.formatString("yyyyMMddHHmmss"))")
        let iOSDirectoryURL = outputDirectoryURL.appendingPathComponent("/iOS")
        let macOSDirectoryURL = outputDirectoryURL.appendingPathComponent("/macOS")
        
        if supportIOS && !FileManager.default.fileExists(atPath: iOSDirectoryURL.path) {
            do {
                try FileManager.default.createDirectory(atPath: iOSDirectoryURL.path, withIntermediateDirectories: true, attributes: nil)
                save(to: iOSDirectoryURL, icons: outputIcon.iOSIcons)
            } catch let error {
                #if DEBUG
                print(error)
                #endif
            }
        }
        
        if supportMacOS && !FileManager.default.fileExists(atPath: macOSDirectoryURL.path) {
            do {
                try FileManager.default.createDirectory(atPath: macOSDirectoryURL.path, withIntermediateDirectories: true, attributes: nil)
                save(to: macOSDirectoryURL, icons: outputIcon.macOSIcons)
            } catch let error {
                #if DEBUG
                print(error)
                #endif
            }
        }
    }
    
    private func resizeImageforMacOS(cgImage: CGImage) -> CGImage? {
        
        guard let cgImage = cgImage.resize(to: CGSize(width: 832, height: 832)) else {
            return nil
        }
        
        let offset: CGFloat = (1024 - 832) / 2
        let context = CGContext(data: nil, width: 1024, height: 1024, bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: cgImage.bitsPerComponent * 1024, space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue)
        
        context?.draw(cgImage, in: CGRect(origin: CGPoint(x: offset, y: offset), size: CGSize(width: 832, height: 832)))
        guard let result = context?.makeImage() else {
            return nil
        }
        
        return result
    }
    
}
