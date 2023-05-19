//
//  SHImagePicker.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/8.
//
#if canImport(UIKit)
import SwiftUI
import UIKit
import Photos

public struct SHImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode

    @Binding var uiimage: UIImage?
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc =  UIImagePickerController()
        vc.delegate = context.coordinator
        vc.allowsEditing = false
//        vc.mediaTypes = ["public.image", "public.movie"]
        vc.sourceType = .photoLibrary
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        let parent: SHImagePicker
        
        init(_ parent: SHImagePicker) {
            self.parent = parent
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiimage = info[.originalImage] as? UIImage {
                parent.uiimage = uiimage
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

public struct SHImagePickerButton: View {
    @Binding var crossImage: CrossImage?
    @State private var showImagePicker: Bool = false
    @State private var showAuthorization: Bool = false

    public var body: some View {
        Button(action: {
            showPicker()
        }) {
            Text("SHImagePicker")
                .padding()
        }
        .sheet(isPresented: $showImagePicker) {
            
        } content: {
            SHImagePicker(uiimage: $crossImage)
        }
        .alert(isPresented: $showAuthorization, content: { .photoLibraryAuthorization })
    }
    
    func showPicker() {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        guard authorizationStatus != .denied && authorizationStatus != .restricted else {
            showAuthorization = true
            return
        }
        
        if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                showImagePicker = true
            }
        } else {
            showImagePicker = true
        }
    }
}

public struct ImagePickerDemoView: View {
    @State private var uiImage: UIImage?
    @State private var showImagePicker: Bool = false
    @State private var showAuthorization: Bool = false

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
                showPicker()
            }) {
                Text("SHImagePicker")
                    .padding()
            }
            .sheet(isPresented: $showImagePicker) {
                
            } content: {
                SHImagePicker(uiimage: $uiImage)
            }
        }
        .navigationBarTitle("SHImagePicker")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAuthorization, content: { .photoLibraryAuthorization })
    }
    
    func showPicker() {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        guard authorizationStatus != .denied && authorizationStatus != .restricted else {
            showAuthorization = true
            return
        }
        
        if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                showImagePicker = true
            }
        } else {
            showImagePicker = true
        }
    }
}

#if DEBUG
struct SHImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerDemoView()
    }
}
#endif
#endif
