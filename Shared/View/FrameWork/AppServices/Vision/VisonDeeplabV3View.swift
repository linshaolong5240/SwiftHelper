//
//  VisonDeeplabV3View.swift
//  SwiftHelper
//
//  Created by 林少龙 on 2023/3/20.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import PhotosUI
import Vision

struct VisonDeeplabV3View: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var inputImage: Image?
    @State private var inputCGImage: CGImage?
    @State private var outputImage: Image?
    @State private var featureName: String? = nil
    
    var body: some View {
        ScrollView {
            Text("input")
            (inputImage ?? Image(systemName: "photo"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(alignment: .bottomTrailing) {
                    PhotosPicker(selection: $selectedItem, matching: .images, preferredItemEncoding: .automatic, photoLibrary: .shared(), label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .font(.system(size: 30))
                    })
                }
            Text("output")
            (inputImage ?? Image(systemName: "photo"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .hidden()
                .overlay(Color.black)
                .overlay {
                    (outputImage ?? Image(systemName: "photo"))
                        .resizable()
                }
            (inputImage ?? Image(systemName: "photo"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay {
                    Text(.now, style: .time)
                        .font(.system(size: 300, weight: .bold, design: .default))
                        .lineLimit(1)
                        .foregroundColor(.accentColor)
                        .minimumScaleFactor(0.1)
                    (inputImage ?? Image(systemName: "photo"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .mask {
                            (outputImage ?? Image(systemName: "photo"))
                                .resizable()
                        }
                }
        }
        .padding()
        .onChange(of: selectedItem) { newValue in
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
#if canImport(AppKit)
                    if let nsImage = NSImage(data: data) {
                        inputCGImage = nsImage.cgImage
                        inputImage = Image(nsImage: nsImage)
                    }
#endif
#if canImport(UIKit)
                    if let uiImage = UIImage(data: data) {
                        inputCGImage = uiImage.cgImage
                        inputImage = Image(uiImage: uiImage)
                    }
#endif
                    request()
                }
            }
        }
    }
    
    func request() {
        let config = MLModelConfiguration()
        //确定是否允许在GPU上进行低精度积累的布尔值。
        config.allowLowPrecisionAccumulationOnGPU = true
        //选择允许模型同时使用CPU和神经引擎的选项，但不允许使用GPU。
        config.computeUnits = .cpuAndNeuralEngine
        guard let model = try? VNCoreMLModel(for: DeepLabV3(configuration: config).model) else {
            return
        }
        
        let request = VNCoreMLRequest(model: model, completionHandler: requestDone)
        request.imageCropAndScaleOption = .scaleFill
        
        guard let cgIamge = inputCGImage else {
            return
        }
        
        DispatchQueue.global().async {
            let handler = VNImageRequestHandler(cgImage: cgIamge, options: [:])
            do {
                try handler.perform([request])
            }catch {
                print(error)
            }
        }
    }
    
    func requestDone(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNCoreMLFeatureValueObservation] else {
#if DEBUG
            if let e = error {
                print("VNImageRequestHandler error: \(e)")
            }
#endif
            return
        }
#if DEBUG
        print("VNCoreMLFeatureValueObservation count: \(results.count)")
#endif
        for (index, result) in results.enumerated() {
            let featureValue = result.featureValue
            guard let multiArrayValue = featureValue.multiArrayValue else {
                return
            }
#if DEBUG
            print("result \(index)")
            print("Feature Name: \(result.featureName)")
            print("MLFeatureType: \(featureValue.type)")
            print("multiArrayValue count : \(multiArrayValue.count)")
            print("multiArrayValue dataType : \(multiArrayValue.dataType)")
            print("multiArrayValue shape count: \(multiArrayValue.shape.count)")
            print("multiArrayValue shape: \(multiArrayValue.shape)")
            print("multiArrayValue strides count: \(multiArrayValue.strides.count)")
            print("multiArrayValue strides: \(multiArrayValue.strides)")
#endif
            if index == 0 {
                var bytes: [UInt8] = Array<UInt8>(repeating: 0, count: 513 * 513)
                for i in 0..<multiArrayValue.count {
                    let value = multiArrayValue[i].int32Value
                    bytes[i] = UInt8(value) > 0 ? 255 : 0
                }
                if let cgImage = bytesToImage(bytes: bytes, width: 513, height: 513) {
                    outputImage = Image(cgImage, scale: 1.0, label: Text("label"))
                }
            }
        }
    }
    
    func cgImageFromMLMultiArray(multiArray: MLMultiArray) -> CGImage? {
//        let bytes: [UInt8] = [0,0,0,0,1,1,1,1]
        guard multiArray.shape.count > 1 else {
          print("Cannot convert MLMultiArray of shape \(multiArray.shape) to image")
          return nil
        }
        //Expected shape for grayscale is (height, width)
        let height: Int = multiArray.shape[1].intValue
        let width: Int = multiArray.shape[0].intValue
        let bitsPerComponent: Int = 8
        let bytesPerRow: Int = width// * 4
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        return multiArray.withUnsafeBytes { ptr in
            let context = CGContext(data: UnsafeMutableRawPointer(mutating: ptr.baseAddress!), width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue)
            return context?.makeImage()
        }
    }
    
    func bytesToImage(bytes: [UInt8], width: Int, height: Int) -> CGImage? {
        //Int(data[1]) | Int(data[0]) << 8
        //Int(data[3]) | Int(data[2]) << 8
        let bitsPerComponent: Int = 8
        let bytesPerRow: Int = width// * 4
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        return bytes.withUnsafeBytes { ptr in
            let context = CGContext(data: UnsafeMutableRawPointer(mutating: ptr.baseAddress!), width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.alphaOnly.rawValue)
            return context?.makeImage()
        }
    }
}

struct VisonDeeplabV3View_Previews: PreviewProvider {
    static var previews: some View {
        VisonDeeplabV3View()
    }
}
