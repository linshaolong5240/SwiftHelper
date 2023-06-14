//
//  SPStringFilter.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/15.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Foundation

protocol SPStringFilter {
    func enfilter(_ value: String) -> String
    func defilter(_ value: String) -> String
}

extension Array: SPStringFilter where Element == SPStringFilter {
    
    func enfilter(_ value: String) -> String {
        reduce(value) { partialResult, element in
            element.enfilter(partialResult)
        }
    }
    
    func defilter(_ value: String) -> String {
        reversed().reduce(value) { partialResult, element in
            element.defilter(partialResult)
        }
    }
    
}

@resultBuilder
enum SPStringFilterBuilder {
    
    static func buildOptional(_ component: SPStringFilter?) -> SPStringFilter {
        component ?? []
    }
    
    static func buildBlock(_ components: SPStringFilter...) -> SPStringFilter {
        components
    }
    
    static func buildArray(_ components: [SPStringFilter]) -> SPStringFilter {
        components
    }
}

struct SPLetterSubtitutionFilter: SPStringFilter {
    let letters: [String]
    let offset: Int
    
    init(offset: Int) {
        self.letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map(String.init)
        self.offset = max(1, min(offset, 25))
    }
    
    func swapLetters(_ value: String, offset: Int) -> String {
        let plaintText = value.map(String.init)
        return plaintText.reduce("") { partialResult, element in
            guard let index = letters.firstIndex(of: element.uppercased()) else {
                return partialResult + element
            }
            let cipherOffset = (index + offset) % letters.count
            let cipherIndex = cipherOffset < 0 ? letters.count + cipherOffset : cipherOffset
            let cipherLetter = letters[cipherIndex]
            return partialResult + cipherLetter
        }
    }
    
    func enfilter(_ value: String) -> String {
        swapLetters(value, offset: offset)
    }
    
    func defilter(_ value: String) -> String {
        swapLetters(value, offset: -offset)
    }
}

struct SPReplaceVocabularyFilter: SPStringFilter {
    let terms: [(original: String, replacement: String)]

    func enfilter(_ value: String) -> String {
        terms.reduce(value) { partialResult, element in
            partialResult.replacingOccurrences(of: element.original, with: element.replacement, options: .caseInsensitive)
        }
    }
    
    func defilter(_ value: String) -> String {
        terms.reduce(value) { partialResult, element in
            partialResult.replacingOccurrences(of: element.replacement, with: element.original, options: .caseInsensitive)
        }
    }
    
}
