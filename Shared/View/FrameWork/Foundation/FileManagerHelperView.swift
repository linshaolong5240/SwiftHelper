//
//  FileManagerHelperView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/6/6.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SearchPathDirectoryInfo: Identifiable {
    var id = UUID()
    var directory: FileManager.SearchPathDirectory
    var url: URL?
}

struct FileManagerHelperView: View {
    @State private var domainSelection: FileManager.SearchPathDomainMask = .userDomainMask
    @State private var dict: Dictionary<FileManager.SearchPathDomainMask, [SearchPathDirectoryInfo]> = [:]
    
    
    var body: some View {
        VStack {
            Picker(selection: $domainSelection, label: Text("Domain")) {
                ForEach(FileManager.SearchPathDomainMask.allCases) { item in
                    Text("\(item)").tag(item)
                }
            }
            List {
                Text("isSandboxEnvironment: \(isSandboxEnvironment() ? "Yes" : "No")")
                Text("temporaryDirectory: \(FileManager.default.temporaryDirectory.path)")
                Divider()
                ForEach(dict[domainSelection] ?? []) { item in
                    Text("\(item.directory):")
                    Text("\(item.url?.path ?? "nil")")
                    Divider()
                }
            }
        }
        .navigationTitle("FileManager")
        .onAppear {
            genearte()
        }
    }
    
    private func genearte() {
        DispatchQueue.global().async {
            var temp: Dictionary<FileManager.SearchPathDomainMask, [SearchPathDirectoryInfo]> = [:]
            _ = FileManager.SearchPathDomainMask.allCases.map { mask in
                temp[mask] = FileManager.SearchPathDirectory.allCases.map { directory in
                    let url = try? FileManager.default.url(for: directory, in: mask, appropriateFor: nil, create: false)
                    return SearchPathDirectoryInfo(directory: directory, url: url)
                }
            }
            DispatchQueue.main.async {
                dict = temp
            }
        }

    }
    
    private func isSandboxEnvironment() -> Bool {
        let environ = ProcessInfo.processInfo.environment
        return nil != environ["APP_SANDBOX_CONTAINER_ID"]
    }
}

#if DEBUG
struct FileManagerView_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerHelperView()
    }
}
#endif
