//
//  SPCurrentAppIconView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/5/9.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SPCurrentAppIconView: View {
    var body: some View {
        Text("Hello, World!")
        Button("Get") {
            getAppIcon()
        }
    }
    
    func getAppIcon() {
        let infoDictionary = Bundle.main.infoDictionary ?? Dictionary<String, Any>()
        
//        print(infoDictionary["CFBundleIcons"])
        let CFBundleIcons = infoDictionary["CFBundleIcons"] as? Dictionary<String, Any> ?? Dictionary<String, Any>()
        let CFBundlePrimaryIcon = CFBundleIcons["CFBundlePrimaryIcon"] as? Dictionary<String, Any> ?? Dictionary<String, Any>()
        let result = CFBundlePrimaryIcon["CFBundleIconFiles"] as? [String] ?? []
        print(result)
    }
}

struct SPCurrentAppIconView_Previews: PreviewProvider {
    static var previews: some View {
        SPCurrentAppIconView()
    }
}
