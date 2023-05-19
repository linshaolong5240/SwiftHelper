//
//  AlertDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/24.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct AlertDemoView: View {
    @State private var showAlert: Bool = false
    @State private var showAlert2: Bool = false

    var body: some View {
        ZStack {
            Color.clear
            .alert(isPresented: $showAlert) {
                Alert(title: Text("With Title"))
            }
            Color.clear
            .alert(isPresented: $showAlert2) {
                Alert(title: Text("With Title"), message: Text("Message"), primaryButton: .destructive(Text("Delete")), secondaryButton: .cancel())
            }
            VStack {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("With Title")
                }
                                
                Button {
                    showAlert2.toggle()
                } label: {
                    Text("Tittle Message Button")
                }
            }
        }
    }
}

#if DEBUG
struct AlertDemoView_Previews: PreviewProvider {
    static var previews: some View {
        AlertDemoView()
    }
}
#endif
