//
//  Date + Extension.swift
//  Pomotron
//
//  Created by Ge Ding on 12/18/23.
//

import Foundation

extension Date {
    
    var calendar: Calendar {
        return Calendar.current
    }
    
    var now: Date {
        return Date()
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
    
    
}
