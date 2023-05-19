//
//  ContentMode+Extension.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/17.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import Foundation
import SwiftUI

extension ContentMode: Identifiable {
    public var id: Int {
        hashValue
    }
}
