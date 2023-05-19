//
//  CryptoHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2021/11/23.
//

import Foundation
import CryptoKit

extension Data {
    func md5() -> String {
        if #available(iOS 13.0, *) {
            let digest = Insecure.MD5.hash(data: self)
            return digest.map { String(format: "%02hhx", $0) }.joined()
        } else {
            return ""
        }
    }
}

extension String {
    func md5() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
