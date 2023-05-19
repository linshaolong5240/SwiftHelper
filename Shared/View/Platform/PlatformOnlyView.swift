//
//  PlatformOnlyView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/12/29.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

import SwiftUI

struct PlatformOnlyView: View {
    let platform: SHPlatform
    
    var body: some View {
        Text("\(platform.name) Only !")
    }
}

struct PlatformiOSOnlyView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformOnlyView(platform: .iOS)
    }
}
