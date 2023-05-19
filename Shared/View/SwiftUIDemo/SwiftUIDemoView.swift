//
//  SwiftUIDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/7/23.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct SwiftUIDemoView: View {
    var body: some View {
        List {
            Section {
                NavigationLink(destination: PreferenceKeyDemoView()) {
                    Text("PreferenceKeyDemo")
                }
                NavigationLink(destination: AnchorPreferenceDemoView()) {
                    Text("AnchorPreferenceDemo")
                }
            } header: {
                Text("PreferenceKey")
            }
            
            Section {
                NavigationLink("Spring") {
                    AnimationSpringDemoView()
                }
            } header: {
                Text("Animation")
            }

            Section {
                NavigationLink(destination: AlertDemoView()) {
                    Text("Alert")
                }
                NavigationLink(destination: PickerDemoView()) {
                    Text("Picker")
                }
                NavigationLink(destination: ScrollViewDemoView()) {
                    Text("ScrollView")
                }
                NavigationLink("Slider") {
                    SliderDemoView()
                }
                NavigationLink(destination: TabViewDemoView()) {
                    Text("TabView")
                }
                NavigationLink("Toggle") {
                    ToggleDemoView()
                }
            } header: {
                Text("Controls")
            }
            
            Section {
                NavigationLink(destination: DatePickerDemoView()) {
                    Text("DatePicker")
                }
#if canImport(PhotosUI) && canImport(UIKit)
                Group {
                    NavigationLink(destination: ImagePickerDemoView()) {
                        Text("SHImagePicker")
                    }
                    NavigationLink(destination: PHPickerDemoView()) {
                        Text("SUIPHPicker")
                    }
                }
#endif
            } header: {
                Text("Picker")
            }
            
            Section {
                NavigationLink("LazyVGrid") {
                    LazyVGridDemoView()
                }
            } header: {
                Text("Layout")
            }
        }
    }
}

#if DEBUG
struct SwiftUIDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIDemoView()
    }
}
#endif
