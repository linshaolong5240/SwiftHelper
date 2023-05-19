//
//  SPAppIconGeneraterView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/4/28.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers.UTType

struct SPAppIconGeneraterView: View {
    @ObservedObject private var vm = SPAppIconGenerater()
    @State private var showResult: Bool = false
    @State private var showFileExporter: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Drop image to generate")
                    .font(.largeTitle)
                Text("Support file type: jepg, png ")
                if let cgImage = vm.inputCGImage {
                    Text("Origin image(size: width=\(cgImage.width) height=\(cgImage.height))")
                    Image.init(cgImage, scale: 1.0, label: Text("App Icon"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .border(Color.accentColor)
                    Button("Save to download directory") {
//                        save()
                        showResult = true
                    }
                    HStack {
                        if vm.supportIOS {
                            if let cgImage = vm.inputiOSCGImage {
                                VStack {
                                    Text("iOS Preview")
                                    Image.init(cgImage, scale: 1.0, label: Text("App Icon"))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .mask { RoundedRectangle(cornerRadius: 10.5, style: .continuous) }
                                        .frame(width: 60, height: 60)
                                        .border(Color.accentColor)
                                }
                            }
                        }
                        if vm.supportMacOS {
                            if let cgImage = vm.inputMacOSCGImage {
                                VStack {
                                    Text("macOS Preview")
                                    Image.init(cgImage, scale: 1.0, label: Text("App Icon"))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 60)
                                        .border(Color.accentColor)
                                }
                            }
                        }
                    }
                    ColorPicker("Background color:", selection: $vm.imageBackgroundColor)
                        .onChange(of: vm.imageBackgroundColor) { newValue in
                            generate()
                        }
                    Picker(selection: $vm.imageContentMode, label: Text("ContentMode:")) {
                        ForEach(ContentMode.allCases) { item in
                            Text(String(describing: item)).tag(item)
                        }
                    }
                    .onChange(of: vm.imageContentMode) { newValue in
                        generate()
                    }
                    HStack {
                        Text("Platform:")
                        Toggle(isOn: $vm.supportIOS) {
                            Text("iOS")
                        }
                        Toggle(isOn: $vm.supportMacOS) {
                            Text("macOS")
                        }
                    }
                    if vm.supportMacOS {
                        Toggle(isOn: $vm.resizeIconForMacOS) {
                            Text("Resize image for macOS")
                            Text("Resize image to 832 * 832 content size in 1024 * 1024 canvas size for macOS app icon")
                        }
                        .onChange(of: vm.resizeIconForMacOS) { newValue in
                            generate()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                }
                SPAppOutputIconView(outputIcon: vm.outputIcon)
            }
            .padding()
        }
        .navigationTitle("App Icon Generater")
        .fileExporter(isPresented: $showResult, documents: vm.outputCGImages.map({ ImageFileDocument(cgImage: $0, type: .png)}), contentType: .png, onCompletion: { result in
            print(result)
        })
        //        .fileExporter(isPresented: $showFileExporter, documents: [ImageFileDocument(image: <#T##CrossImage?#>)], contentType: <#T##UTType#>, onCompletion: <#T##(Result<[URL], Error>) -> Void##(Result<[URL], Error>) -> Void##(_ result: Result<[URL], Error>) -> Void#>)
        //        .fileExporter(isPresented: $showFileExporter, documents: <#_#>, contentType: .png, onCompletion: { result in
        //
        //        })
        .onDrop(of: [.image], delegate: self)
        .onChange(of: vm.inputCGImage) { newValue in
            generate()
        }
    }
    
    private func generate() {
        vm.generateIcon()
        showResult = true
    }
    
    private func save() {
        guard let url = try? FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            return
        }
        vm.save(to: url)
        #if canImport(AppKit)
        NSWorkspace.shared.open(url)
        #endif
    }
}

struct SHAppIconGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        SPAppIconGeneraterView()
    }
}

extension SPAppIconGeneraterView: DropDelegate {
    
    func performDrop(info: DropInfo) -> Bool {
        
        func loadItemDone(item: NSSecureCoding?, error: Error?) {
            guard let url = item as? URL else {
                return
            }
            
            guard let ciImage = CIImage(contentsOf: url) else {
                return
            }
            
            let context = CIContext()
            let cgImage = context.createCGImage(ciImage, from:ciImage.extent)
            
            DispatchQueue.main.async {
                vm.inputCGImage = cgImage
            }
        }
        
        guard let itemProvider = info.itemProviders(for: [.jpeg, .png]).first else {
            return false
        }
        
        itemProvider.loadItem(forTypeIdentifier: UTType.png.identifier, options: nil, completionHandler: loadItemDone)
        
        itemProvider.loadItem(forTypeIdentifier: UTType.jpeg.identifier, options: nil, completionHandler: loadItemDone)
        return true
    }
    
}

private struct SPAppIconPreview: View {
    let icon: SPAppIcon
    
    var body: some View {
        VStack {
            VStack {
                if let cgImage = icon.cgImage {
                    if icon.point * icon.scale > 60 {
                        Image.init(cgImage, scale: 1.0, label: Text("App Icon"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        Image.init(cgImage, scale: 1.0, label: Text("App Icon"))
                    }
                }
            }
            .frame(width: 60, height: 60)
            .border(Color.accentColor)
            Text("\(Int(icon.width).description)x\(Int(icon.height).description)@\(Int(icon.scale))x")
        }
    }
}

private struct SPAppOutputIconView: View {
    let outputIcon: SPOutputAppIcon
    
    var body: some View {
        let columns = [GridItem(.flexible(minimum: 60)), GridItem(.flexible(minimum: 60)), GridItem(.flexible(minimum: 60))]
        LazyVGrid(columns: columns, spacing: 8) {
            Section("iOS") {
                ForEach(outputIcon.iOSIcons) { item in
                    SPAppIconPreview(icon: item)
                }
            }
            Section("macOS") {
                ForEach(outputIcon.macOSIcons) { item in
                    SPAppIconPreview(icon: item)
                }
            }
        }
    }
}
