//
//  Calendar + Extension.swift
//  Pomotron
//
//  Created by Ge Ding on 2/13/24.
//

import Foundation

extension Calendar {
    var currentWeek: [MockDayTasksList] {
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else { return [] }
        var week: [MockDayTasksList] = []
        for index in 0..<7 {
            if let day = self.date(byAdding: .day, value: index, to: firstWeekDay) {
                week.append(MockDayTasksList(date: day, tasks: []))
            }
        }
        return week
    }
    
    var hours: [Date] {
        let startOfDay = self.startOfDay(for: Date())
        var hours: [Date] = []
        for index in 0..<24 {
            if let date = self.date(byAdding: .hour, value: index, to: startOfDay) {
                hours.append(date)
            }
        }
        return hours
    }
}
