//
//  SwiftUITextEditorView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/14.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUITextEditorView: View {
    @State private var text: String = "Placeholder"
    var body: some View {
        TextEditor(text: $text)
            .padding()
    }
}

struct SwiftUITextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITextEditorView()
    }
}
