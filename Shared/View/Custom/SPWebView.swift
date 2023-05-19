//
//  SPWebView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/2/15.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import SwiftUI
import WebKit

@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
@available(watchOS, unavailable)
// FIXME: mac OS 待修复
struct SPWebView: CPViewRepresent {
    let url: URL
    let cachePolicy: URLRequest.CachePolicy
    let timeoutInterval: TimeInterval
    
    init(url: URL, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 60.0) {
        print("SPWebView init")
        self.url = url
        self.cachePolicy = cachePolicy
        self.timeoutInterval = timeoutInterval
    }

    func makeView(context: Context) -> WKWebView {

        let configuration = WKWebViewConfiguration()
//        let dropSharedWorkersScript = WKUserScript(source: "delete window.SharedWorker;", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
//        configuration.userContentController.addUserScript(dropSharedWorkersScript)
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateView(view: WKWebView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: SPWebView
        
        init(_ parent: SPWebView) {
            self.parent = parent
        }
//        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//            print("didStartProvisionalNavigation")
//        }
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            print("didFinish")
//        }
//        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
//            print("webViewWebContentProcessDidTerminate")
//        }
//        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//            print(error)
//        }
    }
}

#if DEBUG
struct SHWebView_Previews: PreviewProvider {
    static var previews: some View {
        SPWebView(url: URL(string: "https://www.baidu.com")!)
//        WebView()
    }
}
#endif

//struct WebView: UIViewRepresentable {
//    func makeUIView(context: Context) -> WKWebView {
//        let webConfiguration = WKWebViewConfiguration()
//        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = context.coordinator
//        webView.navigationDelegate = context.coordinator
//        let request = URLRequest(url: URL(string: "https://www.baidu.com")!)
//        webView.load(request)
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//
//    }
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
//        var parent: WebView
//
//        init(_ parent: WebView) {
//            self.parent = parent
//        }
//        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//            print("didStartProvisionalNavigation")
//        }
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            print("didFinish")
//        }
//        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//            print(error)
//        }
//    }
//
//    typealias UIViewType = WKWebView
//
//
//}
