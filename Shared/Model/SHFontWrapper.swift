//
//  SHFontWrapper.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/8.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

public struct SHFontWrapper: Codable, Hashable, Equatable {
    public var name: String
    public var size: CGFloat

    public init(name: String, size: CGFloat) {
        self.name = name
        self.size = size
    }

}

extension SHFontWrapper {
    public init(_ font: CPFont) {
        self.name = font.fontName
        self.size = font.pointSize
    }
    
    public var uiFont: CPFont? { CPFont(name: name, size: size) }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SHFontWrapper {
    public var font: Font { Font.custom(name, size: size) }
}

extension SHFontWrapper {
    static let `default` = SHFontWrapper(.systemFont(ofSize: 14))
}
