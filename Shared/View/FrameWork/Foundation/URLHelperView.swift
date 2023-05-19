//
//  URLHelperView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/4/6.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import Combine

class URLHelperViewModel: ObservableObject {
    @Published var urlString: String
    @Published var url: URL?
    @Published var urlComponents: URLComponents?
    @Published var queryItemName: String = "score"
    @Published var queryItemValue: String = "100"

    init(urlString: String) {
        self.urlString = urlString
        self.url = URL(string: urlString)
        self.urlComponents = URLComponents(string: urlString)
    }
    
    func appendQueryItem() {
        urlComponents?.queryItems?.append(.init(name: queryItemName, value: queryItemValue))
    }
}

struct URLHelperView: View {
    @ObservedObject private var viewModel = URLHelperViewModel(urlString: "https://www.teenloong.com/user/login?id=1&name=loong")
    
    var body: some View {
        VStack {
            TextField("URL String", text: $viewModel.urlString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            TextField("Query Item Name", text: $viewModel.queryItemName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            TextField("Query Item Value", text: $viewModel.queryItemValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            Button {
                viewModel.appendQueryItem()
            } label: {
                Text("Append Query Item")
            }

            List {
                Group {
                    Text("baseURL: \(viewModel.url?.baseURL?.description ?? "nil")")
                    Text("absoluteString: \(viewModel.url?.absoluteString ?? "nil")")
                    Text("absoluteURL: \(viewModel.url?.absoluteURL.description ?? "nil")")
                    Text("fragment: \(viewModel.url?.fragment ?? "nil")")
                    Text("host: \(viewModel.url?.host ?? "nil")")
                    Text("lastPathComponent: \(viewModel.url?.lastPathComponent ?? "nil")")
                    Text("path: \(viewModel.url?.path ?? "nil")")
                }
                DisclosureGroup("pathComponents", isExpanded: .constant(true)) {
                    ForEach(viewModel.url?.pathComponents ?? [], id: \.self) { item in
                        Text(item)
                    }
                }
                Group {
                    Text("pathExtension: \(viewModel.url?.pathExtension ?? "nil")")
                    Text("port: \(viewModel.url?.port?.description ?? "nil")")
                    Text("query: \(viewModel.url?.query ?? "nil")")
                    Text("relativePath: \(viewModel.url?.relativePath ?? "nil")")
                    Text("relativeString: \(viewModel.url?.relativeString ?? "nil")")
                    Text("scheme: \(viewModel.url?.scheme ?? "nil")")
                    Text("standardized: \(viewModel.url?.standardized.description ?? "nil")")
                    Text("standardizedFileURL: \(viewModel.url?.standardizedFileURL.description ?? "nil")")
                    Text("user: \(viewModel.url?.user ?? "nil")")
                    Text("password: \(viewModel.url?.password ?? "nil")")
                }
                DisclosureGroup("URLQueryItem", isExpanded: .constant(true)) {
                    ForEach(viewModel.urlComponents?.queryItems ?? [], id: \.name) { item in
                        VStack {
                            Text("name: \(item.name)")
                            Text("vale: \(item.value ?? "nil")")
                        }
                    }
                }
            }
        }
    }
}

struct URLHelperView_Previews: PreviewProvider {
    static var previews: some View {
        URLHelperView()
    }
}
