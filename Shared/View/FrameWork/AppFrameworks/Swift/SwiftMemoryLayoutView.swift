//
//  SwiftMemoryLayoutView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/6/9.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftMemoryLayoutView: View {
    var body: some View {
        List {
            Section("Bool") {
                Text("size: \(MemoryLayout<Bool>.size) bytes")
                Text("alignment: \(MemoryLayout<Bool>.alignment) bytes")
                Text("stride: \(MemoryLayout<Bool>.stride) bytes")
            }
            Section("Int") {
                Text("size: \(MemoryLayout<Int>.size) bytes")
                Text("alignment: \(MemoryLayout<Int>.alignment) bytes")
                Text("stride: \(MemoryLayout<Int>.stride) bytes")
            }
            Section("Float") {
                Text("size: \(MemoryLayout<Float>.size) bytes")
                Text("alignment: \(MemoryLayout<Float>.alignment) bytes")
                Text("stride: \(MemoryLayout<Float>.stride) bytes")
            }
            Section("Double") {
                Text("size: \(MemoryLayout<Double>.size) bytes")
                Text("alignment: \(MemoryLayout<Double>.alignment) bytes")
                Text("stride: \(MemoryLayout<Double>.stride) bytes")
            }
        }
    }
}

struct SwiftMemoryLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftMemoryLayoutView()
    }
}
