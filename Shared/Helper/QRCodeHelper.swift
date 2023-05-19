//
//  QRCodeHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2021/12/20.
//

import SwiftUI
import CoreImage

/// https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIQRCodeGenerator
public struct QRCodeHelper {
    /**
     The inputCorrectionLevel parameter controls the amount of additional data encoded in the output image to provide error correction. Higher levels of error correction result in larger output images but allow larger areas of the code to be damaged or obscured without. There are four possible correction modes (with corresponding error resilience levels):

     L: 7%

     M: 15%

     Q: 25%

     H: 30%
     */
    public enum InputCorrectionLevel: String {
        case L, M, Q, H
    }
    /// generateQRCode
    /// - Parameters:
    ///   - data: The data to be encoded as a QR code. An Data object whose display name is Message.
    ///   - level: A single letter specifying the error correction format. An String whose display name is CorrectionLevel. Default value: M.
    ///   - scale: Image transform scale. Default value: 1.0.
    /// - Returns: A Quartz 2D image. You are responsible for releasing the returned image when you no longer need it.
    static public func generateQRCode(inputMessage data: Data, inputCorrection level: InputCorrectionLevel = .M, scale: CGFloat = 1.0) -> CGImage? {
        
        // inputMessage: The data to be encoded as a QR code. An NSData object whose display name is Message.
        // inputCorrectionLevel: A single letter specifying the error correction format. An NSString object whose display name is CorrectionLevel. Default value: M
        guard  let filter = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": level.rawValue]) else {
            return nil
        }
        
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        guard let ciImage = filter.outputImage?.transformed(by: transform) else {
            return nil
        }
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        return cgImage;
    }
    
    /// generateQRCode
    /// - Parameters:
    ///   - data: The data to be encoded as a QR code. An Data object whose display name is Message.
    ///   - level: A single letter specifying the error correction format. An String whose display name is CorrectionLevel. Default value: M.
    ///   - scale: Image transform scale. Default value: 1.0.
    /// - Returns: A Quartz 2D image. You are responsible for releasing the returned image when you no longer need it.
    static public func generateQRCode(inputMessage string: String, inputCorrectionLevel: InputCorrectionLevel = .M, scale: CGFloat = 1.0) -> CGImage? {
        guard let data = string.data(using: .utf8, allowLossyConversion: false) else {
            return nil
        }
        return Self.generateQRCode(inputMessage: data, inputCorrection: inputCorrectionLevel, scale: scale)
    }
    
    enum DetectorAccuracy {
        case low
        case high
        var ciDetectorAccuracy: String {
            switch self {
            case .low:
                return CIDetectorAccuracyLow
            case .high:
                return CIDetectorAccuracyHigh
            }
        }
    }
    
    static func detectQRCode(cgImage: CGImage, accuracy: DetectorAccuracy) -> String? {
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: CIContext(options: nil), options: [CIDetectorAccuracy: accuracy.ciDetectorAccuracy]) else {
            return nil
        }
        guard let features = detector.features(in: CIImage(cgImage: cgImage)) as? [CIQRCodeFeature] else {
            return nil
        }
        
        guard let message = features.first?.messageString else {
            return nil;
        }
        
        return message
    }
}
