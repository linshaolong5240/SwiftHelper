//
//  VisionFrameworkView.swift
//  SwiftHelper
//
//  Created by 林少龙 on 2023/3/20.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct VisionFrameworkView: View {
    var body: some View {
        List {
            NavigationLink("DeeplabV3:Image Segmentation ") {
                VisonDeeplabV3View()
            }
        }
    }
}

struct VisionFrameworkView_Previews: PreviewProvider {
    static var previews: some View {
        VisionFrameworkView()
    }
}
