//
//  SHUnavailableView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/8/20.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SHUnavailableView: View {
    var body: some View {
        Text("Unavailable!")
    }
}

#if DEBUG
struct SHNotSupportView_Previews: PreviewProvider {
    static var previews: some View {
        SHUnavailableView()
    }
}
#endif
