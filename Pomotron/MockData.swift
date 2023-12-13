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
    
    static var mockTasksDic: [Date : [MockTask]] = [
        Calendar.current.date(byAdding: .day, value: 0, to: Date())! : [createTask(0),createTask(0)],
        Calendar.current.date(byAdding: .day, value: 1, to: Date())! : [createTask(1),createTask(1)],
        Calendar.current.date(byAdding: .day, value: 2, to: Date())! : [createTask(2),createTask(2),createTask(2)],
        Calendar.current.date(byAdding: .day, value: 3, to: Date())! : [createTask(3),createTask(3)],
        Calendar.current.date(byAdding: .day, value: 4, to: Date())! : [createTask(4),createTask(4),createTask(4),createTask(4)],
        Calendar.current.date(byAdding: .day, value: 6, to: Date())! : [createTask(6),createTask(6)],
        Calendar.current.date(byAdding: .day, value: 7, to: Date())! : [createTask(7)],
        Calendar.current.date(byAdding: .day, value: 8, to: Date())! : [createTask(8),createTask(8)],
        Calendar.current.date(byAdding: .day, value: 9, to: Date())! : [createTask(9)],
        Calendar.current.date(byAdding: .day, value: 10, to: Date())! : [createTask(10),createTask(10),createTask(10),createTask(10)],
        Calendar.current.date(byAdding: .day, value: 11, to: Date())! : [createTask(11),createTask(11)],
        Calendar.current.date(byAdding: .day, value: 12, to: Date())! : [createTask(12),createTask(12),createTask(12),createTask(12)],
        Calendar.current.date(byAdding: .day, value: 14, to: Date())! : [createTask(14),createTask(14),createTask(14),createTask(14)],
        Calendar.current.date(byAdding: .day, value: 15, to: Date())! : [createTask(15),createTask(15),createTask(15)],
        Calendar.current.date(byAdding: .day, value: 16, to: Date())! : [createTask(16),createTask(16)],
        Calendar.current.date(byAdding: .day, value: 17, to: Date())! : [createTask(17)],
        Calendar.current.date(byAdding: .day, value: 18, to: Date())! : [createTask(18),createTask(18)],
        Calendar.current.date(byAdding: .day, value: 19, to: Date())! : [createTask(19)],
        Calendar.current.date(byAdding: .day, value: 20, to: Date())! : [createTask(20),createTask(20),createTask(20),createTask(20)],
        Calendar.current.date(byAdding: .day, value: 21, to: Date())! : [createTask(21),],
        Calendar.current.date(byAdding: .day, value: 24, to: Date())! : [createTask(24)],
        Calendar.current.date(byAdding: .day, value: 25, to: Date())! : [createTask(25),createTask(25),createTask(25),createTask(25)],
        Calendar.current.date(byAdding: .day, value: 26, to: Date())! : [createTask(26),createTask(26),createTask(26)],
        Calendar.current.date(byAdding: .day, value: 28, to: Date())! : [createTask(28),createTask(28)],
        Calendar.current.date(byAdding: .day, value: 29, to: Date())! : [createTask(29),createTask(29)]
    ]
}

extension MockData {
    private static func createTask(_ dayOffset: Int) -> MockTask {
        var mockTask: MockTask = MockTask()
        let calendar = Calendar.current
        if let day = calendar.date(byAdding: .day, value: -dayOffset, to: Date()) {
            let startTime = calendar.date(byAdding: .hour, value: 1, to: calendar.startOfDay(for: day)) ?? Date()
            let endTime = calendar.date(byAdding: .hour, value: 2, to: calendar.startOfDay(for: day)) ?? startTime
            mockTask = MockTask(addedDate: day, startTime: startTime, endTime: endTime)
        }
        return mockTask
    }
    
    // Function to get the start and end dates of the week
    func weekRange(for date: Date) -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        return (start: startOfWeek, end: endOfWeek)
    }

    // Function to format date range
    func formatWeekRange(from date: Date) -> String {
        let (start, end) = weekRange(for: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return "\(dateFormatter.string(from: start)) - \(dateFormatter.string(from: end))"
    }

    // Function to aggregate tasks by week range
    func aggregateTasksByWeekRange() -> [String: Int] {
        var weeklyTaskCounts = [String: Int]()

        for (date, tasks) in MockData.mockTasksDic {
            let weekRangeStr = formatWeekRange(from: date)
            weeklyTaskCounts[weekRangeStr, default: 0] += tasks.count
        }

        return weeklyTaskCounts
    }

    
}

struct MockTask {
    var id: String = UUID().uuidString
    var title: String = "title"
    var addedDate: Date = Date()
    var startTime: Date = Date()
    var endTime: Date = Date()
}

struct MockTasksForDate: Identifiable {
    var id = UUID().uuidString
    var day: Date
    var tasksCount: Int
}

