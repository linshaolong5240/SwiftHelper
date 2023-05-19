//
//  SHDateFormatterDemoView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/26.
//  Copyright © 2022 com.teenloong. All rights reserved.
//
fileprivate enum FormatterString: String, Identifiable, CaseIterable {
    var id: String { rawValue }
    case formatter1 = "EEEE, MMM d, yyyy"
    case formatter2 = "MM/dd/yyyy"
    case formatter3 = "MM-dd-yyyy HH:mm"
    case formatter4 = "MMM d, h:mm a"
    case formatter5 = "MMMM yyyy"
    case formatter6 = "MMM d, yyyy"
    case formatter7 = "E, d MMM yyyy HH:mm:ss Z"
    case formatter8 = "yyyy-MM-dd'T'HH:mm:ssZ"
    case formatter9 = "dd.MM.yy"
    case formatter10 = "HH:mm:ss.SSS"
}

import SwiftUI

struct DateFormatterHelperView: View {
    @State private var localized: Bool = false
    private let date: Date = Date()
    @State private var formatterString: String = "yyyy-MM-dd'T'HH:mm:ssZ"
    @State private var dateString: String = "2018-09-12T14:11:54+0000"

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Toggle(isOn: $localized) {
                    Text("localized")
                }
                TextField("FormatterString", text: $formatterString)
                TextField("DateString", text: $dateString)
                let date = Date(formatterString: formatterString, dateString: dateString)
                Text(date != nil ? "\(date!)" : "Not match!")
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)

            List {
                Section {
                    ForEach(FormatterString.allCases) { item in
                        VStack(spacing: 10) {
                            Text(item.rawValue)
                                .onTapGesture {
                                    #if canImport(UIKit)
                                    UIPasteboard.general.setValue(item.rawValue, forPasteboardType: "public.plain-text")
                                    #endif
                                }
                            Text(date.formatString(item.rawValue, localized: localized))
                        }
                    }
                } header: {
                    Text("FormatterString")
                }
                
                Section {
                    let dates = Calendar.current.weekDates(date: Date())
                    ForEach(dates, id: \.self) { item in
                        Text("\(item.relativeDateString(dateStyle: .short, timeStyle: .none))")
                        Text("\(item.relativeDateTimeString(to: Date()))")
                        Text("\(item)")
                    }
                } header: {
                    Text("RelativeDate")
                }

            }
        }
    }
}

#if DEBUG
struct SHDateFormatterDemoView_Previews: PreviewProvider {
    static var previews: some View {
        DateFormatterHelperView()
            .environment(\.locale, .init(identifier: "zh"))
    }
}
#endif
