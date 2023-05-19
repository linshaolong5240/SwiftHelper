//
//  SHDEBUGView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/29.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SHDEBUGView: View {
    
    var body: some View {
        //                    FileExportDemo()
        //                    SwiftUIViewExportDemo()
        SHScrollFloatSegmentView()
        //                    AnchorPreferenceDemo2View()
        //                    AnchorPreferenceDemo3View()
        //                    SHRefreshableScrollViewDemo()
        //                    PlatformViewControllerRepresent(SHFloatSegmentTableViewDemoController()).ignoresSafeArea()
        //                        .navigationBarTitleDisplayMode(.inline)
        //                PlatformViewControllerRepresent(AttributedStringDemoController())
    }
}

#if DEBUG
struct SHDEBUGView_Previews: PreviewProvider {
    static var previews: some View {
        SHDEBUGView()
    }
}
#endif
