//
//  TechnologySpecificViews.swift
//  SwiftHelper
//
//  Created by sauron on 2023/3/15.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct TechnologySpecificViews: View {
    var body: some View {
        List {
            NavigationLink("Photos Picker") {
                PhotosPickerView()
            }
        }
    }
}

struct TechnologySpecificViews_Previews: PreviewProvider {
    static var previews: some View {
        TechnologySpecificViews()
    }
}
