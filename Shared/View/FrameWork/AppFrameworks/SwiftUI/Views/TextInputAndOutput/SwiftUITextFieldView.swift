//
//  SwiftUITextFieldView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/2/22.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

fileprivate enum CurrtenField {
    case field1
    case field2
}

struct SwiftUITextFieldView: View {
    @State private var field1 = ""
    @State private var field2 = ""
    @FocusState private var currentField: CurrtenField?
    var body: some View {
        VStack {
            TextField("TextField1", text: $field1)
                .focused($currentField, equals: .field1)
                .submitLabel(.continue)
            TextField("TextField2", text: $field2)
                .focused($currentField, equals: .field2)
                .submitLabel(.send)
            
            Button("Go to field1") {
                currentField = .field1
            }
            
            Button("Go to field2") {
                currentField = .field2
            }
        }
        .textFieldStyle(.roundedBorder)
        .padding()
    }
}

struct SwiftUITextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITextFieldView()
    }
}
