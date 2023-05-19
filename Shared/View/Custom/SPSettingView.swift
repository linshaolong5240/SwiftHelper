//
//  SPSettingView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/2/17.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import StoreKit
#if canImport(UIKit)
import MessageUI
#endif

struct SPSettingView: View {
    @State private var showFeedback: Bool = false
    #if canImport(UIKit)
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    #endif
    var body: some View {
        ZStack {
            Color(red: 249 / 255, green: 249 / 255, blue: 249 / 255)
                .ignoresSafeArea()
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        sectionView {
                            Text("General Settings")
                        } content: {
                            VStack(spacing: 0) {
                                #if canImport(UIKit)
                                settingsRowView(label: "Feed Back") {
                                    guard MailView.canSendMail() else {
                                        return
                                    }
                                    showFeedback.toggle()
                                }
                                .sheet(isPresented: $showFeedback, onDismiss: nil) {
                                    MailView(result: $result)
                                }
                                #endif
                                settingsRowView(label: "Privacy Policy") {
                                    if let url = URL(string: "https://www.baidu.com") {
#if canImport(UIKit)
                                        UIApplication.shared.open(url)
#endif
                                    }
                                }
                                #if canImport(UIKit)
                                settingsRowView(label: "Rate") {
                                    AppStoreHelper.rateApp()
                                }
                                #endif
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Setting")
    }
    
    func settingsRowView(label: String, action: @escaping () -> Void) -> some View {
        Button  {
            action()
        } label: {
            HStack {
                Text(LocalizedStringKey(label))
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
            .frame(height: 56)
        }
    }
    
    func sectionView<Header,Content>(header: () -> Header, content: () -> Content) -> some View where Header: View, Content: View {
        return VStack(spacing: 16) {
            HStack {
                header()
                    .foregroundColor(.secondary)
                Spacer()
            }
            content()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(.white)
            )
        }
    }
}

#if DEBUG
struct SHSettingView_Previews: PreviewProvider {
    static var previews: some View {
        SPSettingView()
    }
}
#endif
