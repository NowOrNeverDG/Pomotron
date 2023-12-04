//
//  MockData.swift
//  Pomotron
//
//  Created by Ge Ding on 12/1/23.
//

import Foundation


class MockData {
    static var mockWeekDayArr: [[WeekDay]] {
        var weekDays1: [WeekDay] = []
        let calendar = Calendar.current
        var weekDays2: [WeekDay] = []

        if let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) {
            for i in 0..<7 {
                if let date = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                    weekDays1.append(WeekDay(date: date))
                }
            }
            
            for i in 1...7 {
                if let date = calendar.date(byAdding: .day, value: -i, to: startOfWeek) {
                    weekDays2.append(WeekDay(date: date))
                }
            }
            
        }
        return [weekDays1,weekDays2]
    }
}

