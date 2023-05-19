//
//  SHIPInfoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/29.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SHIPInfoView: View {
    @State private var ipInfo: String = "nil"
    var body: some View {
        Text("IP Info")
    }
}

#if DEBUG
struct SHIPInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SHIPInfoView()
    }
}
#endif
