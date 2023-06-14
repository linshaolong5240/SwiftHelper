//
//  SwiftResultBuildView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/14.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

//https://www.kodeco.com/39798703-swift-result-builders-getting-started#toc-anchor-010
struct SwiftResultBuildView: View {
    @State private var selection: SPFilterMode = .encode
    @State private var inputText: String = ""
    @State private var outputText: String = ""
    
    var body: some View {
        VStack {
            Text("Input")
            TextEditor(text: $inputText)
                .onChange(of: inputText) { newValue in
                    outputText = processMessage(newValue)
                }
            Picker(selection: $selection, label: EmptyView()) {
                ForEach(SPFilterMode.allCases, id: \.self) { item in
                    Text(item.name).tag(item)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selection) { newValue in
                outputText = processMessage(inputText)
            }
            Text("Output")
            TextEditor(text: $outputText)
        }
        .padding()
    }
    
    func processMessage(_ message: String) -> String {
        let cipher = SPMessageFilter(offset: 1, cycles: 3, useVocabularyReplacement: true)
        switch selection {
        case .encode:
            return cipher.cipherRule.enfilter(message)
        case .decode:
            return cipher.cipherRule.defilter(message)
        }
    }
}

struct SwiftResultBuildView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftResultBuildView()
    }
}

fileprivate enum SPFilterMode: CaseIterable {
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

struct SPMessageFilter {
    let offset: Int
    let cycles: Int
    let useVocabularyReplacement: Bool
    
    init(offset: Int, cycles: Int = 1, useVocabularyReplacement: Bool = false) {
        self.offset = offset
        self.cycles = cycles
        self.useVocabularyReplacement = useVocabularyReplacement
    }

    @SPStringFilterBuilder
    var cipherRule: SPStringFilter {
        if useVocabularyReplacement {
            SPReplaceVocabularyFilter(terms: [
              ("SECRET", "CHOCOLATE"),
              ("MESSAGE", "MESS"),
              ("PROTOCOL", "LEMON GELATO"),
              ("DOOMSDAY", "BLUEBERRY PIE")
            ])
        }
        for _ in 0..<cycles {
            SPLetterSubtitutionFilter(offset: offset)
        }
    }
}
