//
//  SwiftUITextInputAndOutputView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/2/22.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUITextInputAndOutputView: View {
    var body: some View {
        List {
            NavigationLink("Text") {
                SwiftUITextView()
            }
            NavigationLink("TextField") {
                SwiftUITextFieldView()
            }
        }
    }
}

struct SwiftUITextInputAndOutputView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITextInputAndOutputView()
    }
}
