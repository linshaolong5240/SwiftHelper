//
//  DateHelper.swift
//  SwiftHelper
//
//  Created by sauron on 2021/11/23.
//

import Foundation

extension Date {
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var isYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isToday: Bool { Calendar.current.isDateInToday(self) }
    var isTomorrow: Bool { Calendar.current.isDateInTomorrow(self) }
    var isRelativeDay: Bool { isYesterday || isToday || isTomorrow }
    
    func nextMinute() -> Date {
        Calendar.current.dateInterval(of: .minute, for: self)!.end
    }
    
    func nextHour() -> Date {
        Calendar.current.dateInterval(of: .hour, for: self)!.end
    }
    
    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func endOfDay() -> Date {
        Calendar.current.dateInterval(of: .day, for: self)!.end
    }
}
