//
//  SHCalendarView.swift
//  SwiftHelper
//
//  Created by sauron on 2021/6/10.
//

import SwiftUI

@available(iOS 14.0, *)
struct SHCalendarWeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let hSpacing: CGFloat?
    let content: (Date) -> DateView

    init(week: Date,
         hSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.hSpacing = hSpacing
        self.content = content
    }

    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        HStack(spacing: hSpacing) {
            ForEach(days, id: \.self) { date in
                if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                    self.content(date)
                } else {
                    self.content(date).hidden()
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct SHCalendarMonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let month: Date
    let hSpacing: CGFloat?
    let vSpacing: CGFloat?
    let content: (Date) -> DateView

    init(
        month: Date,
        hSpacing: CGFloat? = nil,
        vSpacing: CGFloat? = nil,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.hSpacing = hSpacing
        self.vSpacing = vSpacing
        self.content = content
    }

    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
            else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }

    var body: some View {
        VStack(spacing: vSpacing) {
            Text("\(month.month)")
            ForEach(weeks, id: \.self) { week in
                SHCalendarWeekView(week: week, hSpacing: hSpacing, content: self.content)
            }
        }
    }
}

@available(iOS 14.0, *)
struct SHCalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let content: (Date) -> DateView

    init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(months, id: \.self) { month in
                    SHCalendarMonthView(month: month, content: self.content)
                }
            }
        }
    }
}

struct SHCalendarViewDemo: View {
    
    var body: some View {
        ScrollView {
            SHCalendarView(interval: Calendar.current.dateInterval(of: .year, for: Date())!) { date in
              Text(String(Calendar.current.component(.day, from: date)))
    //            .frame(width: 40, height: 40, alignment: .center)
                .frame(minWidth: 20, idealWidth: 40, maxWidth: 40, minHeight: 20, idealHeight: 40, maxHeight: 40, alignment: .center)
                .background(Color.blue)
                .clipShape(Circle())
                .padding(.vertical, 4)
            }
        }
    }
}

#if DEBUG
@available(iOS 14.0, *)
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
//        SHCalendarMonthView(month: Date()) { date in
//            Text(String(Calendar.current.component(.day, from: date)))
//                //            .frame(width: 40, height: 40, alignment: .center)
//                .frame(minWidth: 20, idealWidth: 40, maxWidth: 40, minHeight: 20, idealHeight: 40, maxHeight: 40, alignment: .center)
//                .background(
//                    Circle()
//                        .fill(Calendar.current.isDateInToday(date) ? Color.pink : Color.blue)
//                )
//                .padding(.vertical, 4)
//        }
        SHCalendarViewDemo()
    }
}
#endif
