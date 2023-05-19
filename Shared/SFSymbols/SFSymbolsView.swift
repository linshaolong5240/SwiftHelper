//
//  SFSymbolsView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/3/24.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SFSymbolsView: View {
    @State private var fontSize: CGFloat = 30
    
    var body: some View {
        VStack {
            List {
                Image(systemName: "pencil.circle.fill")
                    .symbolRenderingMode(.multicolor)
                            .font(.system(size: fontSize))
                //            .foregroundColor(.accentColor)
            }
            Text("Font Size")
            Slider(value: $fontSize, in: 10...80) {
                Text("Font Size")
            } minimumValueLabel: {
                Text("10")
            } maximumValueLabel: {
                Text("80")
            }
            .padding(.horizontal)
        }
    }
}

struct SFSymbolsView_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolsView()
    }
}
