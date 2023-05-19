//
//  URLHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2021/12/28.
//

import Foundation

extension URL {
    var image: CrossImage? { CrossImage(contentsOfFile: path) }
}

extension URL {
    var queryItems: [URLQueryItem]? { URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems }
    
    var queryDictionary: [String: String] {
        var dict = [String: String]()
        queryItems?.forEach { item in
            dict[item.name] = item.value
        }
        return dict
    }
}
