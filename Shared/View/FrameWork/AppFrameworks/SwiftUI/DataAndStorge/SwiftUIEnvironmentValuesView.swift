//
//  SwiftUIEnvironmentValuesView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/2/21.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUIEnvironmentValuesView: View {
    @State private var showDissmissDemo: Bool = false
    var body: some View {
        Button("Environment: dissmiss") {
            showDissmissDemo.toggle()
        }
        .sheet(isPresented: $showDissmissDemo) {
            DissmissView()
        }
    }
}

fileprivate
struct DissmissView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button("dissmiss") {
            dismiss()
        }
    }
}

struct SwiftUIEnvironmentValuesView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIEnvironmentValuesView()
    }
}
