//
//  Date + Extension.swift
//  Pomotron
//
//  Created by Ge Ding on 12/18/23.
//

import Foundation

extension Date {
    
    fileprivate var calendar: Calendar {
        return Calendar.current
    }
    
    fileprivate var now: Date {
        return Date()
    }
    
    fileprivate var formatter: DateFormatter {
        return DateFormatter()
    }
    
    var isInCurrentWeek: Bool {
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: now)?.start
        let endOfWeek = calendar.dateInterval(of: .weekOfYear, for: now)?.end
        return self >= startOfWeek! && self < endOfWeek!
    }
    
    var isInCurrentMonth: Bool {
        let startOfMonth = calendar.dateInterval(of: .weekOfYear, for: now)?.start
        let endOfMonth = calendar.dateInterval(of: .weekOfYear, for: now)?.end
        return self >= startOfMonth! && self < endOfMonth!
    }
    
    static func startDateOfWeek(_ year: Int,_ weekOfYear: Int) -> Date? {
        let calendar = Calendar.current
        let components = DateComponents(year: year, weekOfYear: weekOfYear)
        guard let startOfWeek = calendar.date(from: components) else { return nil }
        return startOfWeek
    }
    
    static func endDateOfWeek(_ year: Int,_ weekOfYear: Int) -> Date? {
        let calendar = Calendar.current
        let components = DateComponents(year: year, weekOfYear: weekOfYear)
        guard let startOfWeek = calendar.date(from: components) else { return nil }
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else { return nil }
        return endOfWeek
    }
    
    func toString(_ format: String) -> String {
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    /// Checking Whether the Date is Today
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    /// Checking if the date is Same Hour
    var isSameHour: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedSame
    }
    
    /// Checking if the date is Past Hours
    var isPast: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedAscending
    }
    
    func isSameDate(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
}
