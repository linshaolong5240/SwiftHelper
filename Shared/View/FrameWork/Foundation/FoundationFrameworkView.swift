//
//  FoundationFrameworkView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/28.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct FoundationFrameworkView: View {
    var body: some View {
        List {
            Section("App Support") {
                NavigationLink("Bundle") {
                    BundleView()
                }
            }
            NavigationLink("DateFormatter") {
                DateFormatterHelperView()
            }
            NavigationLink("Calendar") {
                CalendarHelperView()
            }
            NavigationLink("FileManager") {
                FileManagerHelperView()
            }
            NavigationLink("Locale") {
                LocaleHelperView()
            }
        }
    }
}

struct FoundationHelper_Previews: PreviewProvider {
    static var previews: some View {
        FoundationFrameworkView()
    }
}
