//
//  MailView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/1/18.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MFMailComposeViewController
    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
                let vc = MFMailComposeViewController()
                vc.mailComposeDelegate = context.coordinator
                vc.setToRecipients(["example@mail.com"])
        //        vc.setSubject("Hello!")
        //        vc.setMessageBody("Hello from California!", isHTML: false)
                return vc
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<MailView>) {

    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView

        init(_ parent: MailView) {
            self.parent = parent
        }

        func mailComposeController(_ controller: UIViewControllerType,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                parent.presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                parent.result = .failure(error!)
                return
            }
            parent.result = .success(result)
        }
    }
    
    static func canSendMail() -> Bool {
        MFMailComposeViewController.canSendMail()
    }
}

struct MailViewDemoView: View {
    @State private var showMail: Bool = false
    @State private var result: Result<MFMailComposeResult, Error>? = nil

    var body: some View {
        VStack {
            Text("canSendMail: \(MailView.canSendMail() ? "true" : "false")")
            Button {
                guard MailView.canSendMail() else {
                    return
                }
                showMail.toggle()
            } label: {
                Text("Show Mail")
            }
            .sheet(isPresented: $showMail, onDismiss: nil) {
                MailView(result: $result)
                
            }
        }
        .navigationTitle("Mail View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        MailViewDemoView()
    }
}
#endif
