//
//  SwiftResultBuildView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/14.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

fileprivate enum Selection: CaseIterable {
    case encode
    case decode
    
    var name: String {
        switch self {
        case .encode:
            return "Encode"
        case .decode:
            return "Decode"
        }
    }
}

struct SwiftResultBuildView: View {
    @State private var selection: Selection = .encode
    @State private var inputText: String = ""
    @State private var outputText: String = ""
    
    var body: some View {
        VStack {
            TextEditor(text: .constant("PlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholder"))
            Picker(selection: $selection, label: EmptyView()) {
                ForEach(Selection.allCases, id: \.self) { item in
                    Text(item.name).tag(item)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            TextEditor(text: .constant("PlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholderPlaceholder"))
        }
        .padding()
    }
}

struct SwiftResultBuildView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftResultBuildView()
    }
}
