//
//  SPLanguageInteroperabilityView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/19.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI
import SPC
//import SPCPP
import SPObjectiveC

struct SPLanguageInteroperabilityView: View {
    var body: some View {
        VStack {
            Button("Swift call c function") {
                SPCTest()
            }
//            Button("Swift call cpp function") {
//                SPCPPTest()
//            }
            Button("Swift call objective-c function") {
                SPObjectiveCTest().test()
            }
        }
        .padding()
    }
}

struct SPLanguageInteroperability_Previews: PreviewProvider {
    static var previews: some View {
        SPLanguageInteroperabilityView()
    }
}
