//
//  DatePickerDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/5/16.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct DatePickerDemoView: View {
    @State private var selection: Date = Date()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text("DefaultDatePickerStyle")
                    DatePicker(selection: $selection, label: { Text("Date") })
                    Text("GraphicalDatePickerStyle")
                    DatePicker(selection: $selection, label: { Text("Date") })
                        .datePickerStyle(.graphical)
                    #if canImport(UIKit)
                    Text("CompactDatePickerStyle")
                    DatePicker(selection: $selection, label: { Text("Date") })
                        .datePickerStyle(.compact)
                    Text("WheelDatePickerStyle")
                    DatePicker(selection: $selection, label: { Text("Date") })
                        .datePickerStyle(.wheel)
                    #endif
                    #if canImport(AppKit)
                    Text("FieldDate PickerStyle")
                    DatePicker(selection: $selection, label: { Text("Date") })
                        .datePickerStyle(.field)
                    Text("StepperFieldDatePickerStyle")
                    DatePicker(selection: $selection, label: { Text("Date") })
                        .datePickerStyle(.stepperField)
                    #endif
                }
                
                Group {
                    Text("displayedComponents: [.date]")
                    DatePicker(selection: $selection, displayedComponents: [.date], label: { Text("Date") })
                    Text("displayedComponents: [.hourAndMinute]")
                    DatePicker(selection: $selection, displayedComponents: [.hourAndMinute], label: { Text("Date") })
                }

            }
            .padding()
        }
    }
}

#if DEBUG
struct DatePickerDemo_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerDemoView()
    }
}
#endif
