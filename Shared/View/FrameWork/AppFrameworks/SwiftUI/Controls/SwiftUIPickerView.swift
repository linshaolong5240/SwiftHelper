//
//  SwiftUIPickerView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/4/29.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUIPickerView: View {
    @State private var selection: Int = 1
    
    var body: some View {
        List {
            Picker(selection: $selection, label: Text("Default Picker Style")) {
                Text("1").tag(1)
                Text("2").tag(2)
            }
            Picker(selection: $selection, label: Text("Inline Picker Style")) {
                Text("1").tag(1)
                Text("2").tag(2)
            }
            .pickerStyle(.inline)
            Picker(selection: $selection, label: Text("Menu Picker Style")) {
                Text("1").tag(1)
                Text("2").tag(2)
            }
            .pickerStyle(.menu)
            #if canImport(UIKit)
            Picker(selection: $selection, label: Text("Navigation Link Picker Style")) {
                Text("1").tag(1)
                Text("2").tag(2)
            }
            .pickerStyle(.navigationLink)
            #endif
            #if canImport(AppKit)
            Picker(selection: $selection, label: Text("Radio Group Picker Style")) {
                Text("1").tag(1)
                Text("2").tag(2)
            }
            .pickerStyle(.radioGroup)
            #endif
            Picker(selection: $selection, label: Text("Segmented Picker Style")) {
                Text("1").tag(1)
                Text("2").tag(2)
            }
            .pickerStyle(.segmented)
            #if canImport(UIKit)
            Picker(selection: $selection, label: Text("Wheel Picker Style")) {
                Text("1").tag(1)
                Text("2").tag(2)
            }
            .pickerStyle(.wheel)
            #endif
        }
    }
}

struct SwiftUIPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIPickerView()
    }
}
