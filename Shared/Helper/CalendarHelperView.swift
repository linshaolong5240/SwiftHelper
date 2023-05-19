//
//  CalendarHelperView.swift
//  SwiftHelper
//
//  Created by sauron on 2022/3/27.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI

struct CalendarHelperView: View {
    private let now: Date = Date()
    struct ToggleStates {
        var oneIsOn: Bool = false
        var twoIsOn: Bool = true
    }
    @State private var toggleStates = ToggleStates()
    @State private var topExpanded: Bool = false
    var body: some View {
        List {
            Section(content: {
                DisclosureGroup("identifier: \(String(describing: Calendar.current.identifier))", isExpanded: $topExpanded) {
                    ForEach(Calendar.Identifier.allCases, id: \.self) { item in
                        Text(String(describing: item))
                    }
                }
                Text("local: \(Calendar.current.locale?.description ?? "nil")")
                Text("firstWeekDay: \(Calendar.current.firstWeekday) (1 is Sunday.)")
                Text("minimumDaysInFirstWeek: \(Calendar.current.minimumDaysInFirstWeek)")
                Text("timeZone: \(Calendar.current.timeZone)")
            }, header: {
                Text("Calendar Information")
            })
            Text("Next Minute: \(Calendar.current.nextMinute(for: now))")
            Text("Next Hour: \(Calendar.current.nextHour(for: now))")
            Text("Next Day: \(Calendar.current.nextDay(for: now))")
            VStack {
                Text("Timer Date: \(Calendar.current.generateSecondsRefreshTimerDate(date: now))")
                SHSecondsRefreshTimeView(Calendar.current.generateSecondsRefreshTimerDate(date: now))
            }
            
            Section(content: {
                ForEach(Array(zip(Calendar.current.weekDates(date: now).indices, Calendar.current.weekDates(date: now))), id: \.0) { index, item in
                    Text("\(item)")
                }
            }, header: {
                Text("Week Dates")
            })
        }
    }
}

#if DEBUG
struct CalendarHelperView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHelperView()
    }
}
#endif
