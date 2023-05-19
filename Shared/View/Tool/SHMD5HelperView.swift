//
//  SHMD5HelperView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/10/3.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers

struct SHMD5HelperView: View {
    @AppStorage("md5_file_path") private var filePath: String = ""
    @State private var md5: String = ""

    var body: some View {
        VStack {
            HStack {
                Text("File path:")
                TextField("File path", text: $filePath)
            }
            TextField("File path", text: $md5)
            Button(action: {
                let fileURL = URL(fileURLWithPath: filePath)
                do {
                    let data = try Data(contentsOf: fileURL)
                    md5 = data.md5()
                } catch {
                    #if DEBUG
                    print(error)
                    #endif
                }
            }, label: {
                Text("check md5")
            })
        }
        .padding()
        .onDrop(of: [.fileURL], delegate: self)
        //        .onDrop(of: [], isTargeted: $isTargeted) { providers, location in
//            #if DEBUG
////            printf("location: \(location)")
//            #endif
//        }
    }
}

#if DEBUG
struct SHMD5HelperView_Previews: PreviewProvider {
    static var previews: some View {
        SHMD5HelperView()
    }
}
#endif

extension SHMD5HelperView: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        guard let itemProvider = info.itemProviders(for: [.fileURL]).first else { return false }
        
        itemProvider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) {item, error in
            guard let data = item as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) else { return }
            // Do something with the file url
            // remember to dispatch on main in case of a @State change
            DispatchQueue.main.async {
//                fileURL = url
                filePath = url.path
            }
            #if DEBUG
            print(url.path)
            #endif
        }
        return true
    }
}
