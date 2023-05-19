//
//  SUIPHPicker.swift
//  SwiftHelper
//
//  Created by sauron on 2021/12/4.
//

#if canImport(PhotosUI) && canImport(UIKit)
import SwiftUI
import PhotosUI

public struct SUIPHPicker: UIViewControllerRepresentable {
    public typealias UIViewControllerType = PHPickerViewController

    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var imageName: UIImage?
    let configuration: PHPickerConfiguration
    var didFinishPickingHandler: ((UIImage) -> UIImage)? = nil
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        let vc = PHPickerViewController(configuration: configuration)
        vc.delegate = context.coordinator
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: PHPickerViewControllerDelegate {
        private let parent: SUIPHPicker
        
        init(_ parent: SUIPHPicker) {
            self.parent = parent
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let itemProvider = results.first?.itemProvider {
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { imageName, error in
                        DispatchQueue.main.async { [weak self] in
                            guard let weakSelf = self else { return }
                            guard let uiimage = imageName as? UIImage else {
                                weakSelf.parent.imageName = UIImage(systemName: "exclamationmark.circle")
                                #if DEBUG
                                print("Couldn't load image with error: \(error?.localizedDescription ?? "unknown error")")
                                #endif
                                return
                            }
                            weakSelf.parent.imageName = weakSelf.parent.didFinishPickingHandler?(uiimage) ?? uiimage
                        }
                    }
                } else {
                    #if DEBUG
                    print("Unsupported item provider: \(itemProvider)")
                    #endif
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

public struct PHPickerDemoView: View {
    @State private var uiImage: UIImage?
    @State private var showImagePicker: Bool = false
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                let frame = geometry.frame(in: .local)
                if let imageName = uiImage {
                    Image(uiImage: imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: frame.width, height: frame.height)
                        .cornerRadius(0)
                }else {
                    Color.orange
                }
            }
            .padding()
            .background(Color.white)
            .frame(width: 200, height: 200)
            .cornerRadius(10)
            .shadow(radius: 10)

            Button(action: {
                showImagePicker = true
            }) {
                Text("SUIPHPicker")
                    .padding()
            }
            .sheet(isPresented: $showImagePicker) {
                
            } content: {
                SUIPHPicker(imageName: $uiImage, configuration: phpickerConfiguration, didFinishPickingHandler: nil)
                
            }
        }
        .navigationBarTitle("SUIPHPicker")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var phpickerConfiguration: PHPickerConfiguration {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        configuration.selectionLimit = 1
        return configuration
    }
}

#if DEBUG
struct PHPicker_Previews: PreviewProvider {
    static var previews: some View {
        PHPickerDemoView()
    }
}
#endif

#endif
