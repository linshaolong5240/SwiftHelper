//
//  SwiftUIAnimationsView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/2/21.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUIAnimationsView: View {
    @State private var scaledUp = true

    var body: some View {
        VStack {
            Text("Hello, world!")
                .scaleEffect(scaledUp ? 2 : 1)
                .animation(.linear(duration: 2), value: scaledUp)
                .onTapGesture { scaledUp.toggle() }
        }
    }
}

struct SwiftUIAnimationsView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIAnimationsView()
    }
}
