//
//  ContactsUIDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/12/14.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import SwiftUI
import ContactsUI

struct ContactsUIDemoView: View {
    var body: some View {
        List {
            NavigationLink("CNContactViewController") {
                PlatformViewControllerRepresent(CNContactViewController())
            }
            #if os(iOS)
            Button {
                
            } label: {
                Text("CNContactPickerViewController")
            }
            #endif
            #if os(macOS)
            Button {
                
            } label: {
                Text("CNContactPicker")
            }
            #endif
        }
    }
}

struct ContactsUIDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsUIDemoView()
    }
}
