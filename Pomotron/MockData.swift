//
//  MockData.swift
//  Pomotron
//
//  Created by Ge Ding on 12/1/23.
//

import Foundation
import Charts
//Single Task
struct MockTask: Identifiable {
    
    let id: String
    let title: String
    let addedTime: Date
    var startTime: Date
    var endTime: Date
    var tag: TaskTag
    
    init(id: String = UUID().uuidString, title: String = "#Test Title#", addedTime: Date = Date(), startTime: Date = Date(), endTime: Date = Date(), tag: TaskTag = .black) {
        self.id = id
        self.title = title
        self.addedTime = addedTime
        self.startTime = startTime
        self.endTime = endTime
        self.tag = tag
    }
}
//One Day Tasks collection
struct MockDayTasksList: Identifiable {
    let id: String
    let date: Date
    let tasks: [MockTask]
    
    init(id: String = UUID().uuidString, date: Date, tasks: [MockTask]) {
        self.id = id
        self.date = date
        self.tasks = tasks
    }
    
    var taskCount: Int { return tasks.count }
}
//One week Tasks collection
struct MockWeekTasksList: Identifiable {
    let id: String
    let year: Int
    let week: Int
    let tasks: [MockDayTasksList]
    
    init(id: String = UUID().uuidString,year: Int,week: Int, tasks: [MockDayTasksList]) {
        self.id = id
        self.year = year
        self.week = week
        self.tasks = tasks
    }
    
    private let calendar = Calendar.current
    private var components: DateComponents { return DateComponents(weekOfYear: self.week, yearForWeekOfYear: self.year) }

    var tasksCount: Int { return self.tasks.reduce(0) { $0 + $1.tasks.count } }

    var startDate:Date? {
        guard let startOfWeek = calendar.date(from: components) else { return nil }
        return startOfWeek
    }
    var endDate:Date? {
        guard let startOfWeek = calendar.date(from: components) else { return nil }
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else { return nil }
        return endOfWeek
    }
    
    var dateRange: String {
        return "\(startDate?.format("M/dd") ?? "N/A")-\(endDate?.format("M/dd") ?? "N/A")"
    }

}
//One month Tasks collection
struct MockMonthTasksList: Identifiable {
    let id: String
    let dateRange: String
    let year: String
    let month: String
    let tasks: [MockDayTasksList]
    
    init(id: String, dateRange: String, year: String, month: String, tasks: [MockDayTasksList]) {
        self.id = id
        self.dateRange = dateRange
        self.year = year
        self.month = month
        self.tasks = tasks
    }
}

struct MockTagCountPair: Identifiable {
    var id: String
    var tag: TaskTag
    var tagCount: Int
    
    init(id: String = UUID().uuidString, tag: TaskTag, tagCount: Int) {
        self.id = id
        self.tag = tag
        self.tagCount = tagCount
    }
}

//Recent 28 days Daily Tasks collection
struct MockRecent28DaysTasksList: Identifiable {
    let id: String
    let recentDaysTasksArr: [MockDayTasksList]
    
    init(id: String = UUID().uuidString, recentDaysTasksArr: [MockDayTasksList]) {
        self.id = id
        self.recentDaysTasksArr = recentDaysTasksArr
    }
    
    var totalCount: Int { return recentDaysTasksArr.reduce(0){ $0 + $1.taskCount } }
}
//Recent 7 days Daily Task
struct MockRecent7DaysTasksList: Identifiable {
    let id: String
    let recentDaysTasksArr: [MockDayTasksList]
    
    init(id: String = UUID().uuidString, recentDaysTasksArr: [MockDayTasksList]) {
        self.id = id
        self.recentDaysTasksArr = recentDaysTasksArr
    }
    
    private var daysCount: Int { return self.recentDaysTasksArr.count }

    var totalCount: Int { return self.recentDaysTasksArr.reduce(0){ $0 + $1.taskCount } }
    var average: Float { return Float(totalCount) / Float(daysCount) }
}
//Recent 28 days Tag Distribution
struct MockRecent28DaysTagList: Identifiable {
    let id: String
    let tagDic: [(TaskTag,Int)]
    
    init(id: String = UUID().uuidString, tagDic: [(TaskTag,Int)]) {
        self.id = id
        self.tagDic = tagDic
    }
}


class MockData {
    static var mockWeekDayArr: [[MockDayTasksList]] {
        let calendar = Calendar.current

        var weekDays1: [MockDayTasksList] = []
        var weekDays2: [MockDayTasksList] = []

        if let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) {
            for i in 0..<7 {
                if let date = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                    weekDays1.append(MockDayTasksList(date: date, tasks: []))
                }
            }
            
            for i in 1...7 {
                if let date = calendar.date(byAdding: .day, value: -i, to: startOfWeek) {
                    weekDays2.append(MockDayTasksList(date: date, tasks: []))
                }
            }
            
        }
        return [weekDays1,weekDays2]
    }

    ///SumView
    static var mockWeeklyTasksCount: Int {
        return mockDayTasksArr.filter{$0.date.isInCurrentWeek }.reduce(0) { $0 + $1.taskCount }
    }
    static var mockDailyTasksCount: Int {
        return mockDayTasksArr.filter{ $0.date.isToday }.reduce(0) { $0 + $1.taskCount }
    }
    static var mockMonthlyTasksCount: Int {
        return mockDayTasksArr.filter{ $0.date.isInCurrentMonth }.reduce(0) { $0 + $1.taskCount }
    }
    
    ///Source of Truth: all Tasks
    static var mockAllTasksArr: [MockTask] {
        return mockDayTasksArr.reduce([MockTask]()) { $0 + $1.tasks }
    }
    
    static var mockTagCountPairArr: [MockTagCountPair] {
        var res = [TaskTag:Int]()
        for task in mockAllTasksArr {
            res[task.tag, default: 0] += 1
        }
        var final = [MockTagCountPair]()
        for task in res {
            final.append(MockTagCountPair(tag: task.key, tagCount:task.value))
        }
        return final
    }
    ///Source of Truth: Tasks List by day
    static var mockDayTasksArr:[MockDayTasksList] = [
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!, tasks: [createTask(0,.black),createTask(0,.blue)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, tasks: [createTask(1,.red),createTask(1,.yello)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, tasks: [createTask(2,.pink),createTask(2,.blue),createTask(2,.yello),createTask(2,.yello),createTask(2,.yello),createTask(2,.yello),createTask(2,.yello),createTask(2,.yello),createTask(2,.yello),createTask(2,.yello)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, tasks: [createTask(3,.blue),createTask(3,.pink)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, tasks: [createTask(4,.black),createTask(4,.red),createTask(4,.yello),createTask(4,.gray)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, tasks: [createTask(6,.pink),createTask(6,.yello)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, tasks: [createTask(7,.blue)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -8, to: Date())!, tasks: [createTask(8,.yello),createTask(8,.blue)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -9, to: Date())!, tasks: [createTask(9,.black)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, tasks: [createTask(10,.gray),createTask(10,.pink),createTask(10,.yello),createTask(10,.gray)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -11, to: Date())!, tasks: [createTask(11,.black),createTask(11,.pink)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -12, to: Date())!, tasks: [createTask(12,.pink),createTask(12,.blue),createTask(12,.black),createTask(12,.gray)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -14, to: Date())!, tasks: [createTask(14,.black),createTask(14,.gray),createTask(14,.blue),createTask(14,.blue)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -15, to: Date())!, tasks: [createTask(15,.blue),createTask(15,.gray),createTask(15,.blue)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -16, to: Date())!, tasks: [createTask(16,.pink),createTask(16,.yello)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -17, to: Date())!, tasks: [createTask(17,.red)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -18, to: Date())!, tasks: [createTask(18,.black),createTask(18,.gray)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -19, to: Date())!, tasks:[createTask(19,.blue)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -20, to: Date())!, tasks:[createTask(20,.black),createTask(20,.blue),createTask(20,.gray),createTask(20,.blue)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -21, to: Date())!, tasks:[createTask(21,.blue)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -24, to: Date())!, tasks:[createTask(24,.black)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -25, to: Date())!, tasks:[createTask(25,.pink),createTask(25,.black),createTask(25,.blue),createTask(25,.gray)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -26, to: Date())!, tasks:[createTask(26,.black),createTask(26,.black),createTask(26,.black)]),
        MockDayTasksList(date: Calendar.current.date(byAdding: .day, value: -28, to: Date())!, tasks:[createTask(28,.blue),createTask(28,.blue)])
    ]
    ///Source of Truth: Recent 28 days Tasks
    static var mockRecent28DaysTasks: MockRecent28DaysTasksList {
        return MockRecent28DaysTasksList(recentDaysTasksArr: mockDayTasksArr)
    }
    ///Source of Truth: Recent 7 days Tasks
    static var mockRecent7DaysTasks: MockRecent7DaysTasksList {
        var days = [MockDayTasksList]()
        for i in (0..<7).reversed() {
            days.append(mockDayTasksArr[i])
        }
        return MockRecent7DaysTasksList(recentDaysTasksArr: days)
    }
    ///Source of Truth:
    static var mockRecent4WeeksWeeklyTasksArr: [MockWeekTasksList] {
        let weeklyTasksArr = [
            MockWeekTasksList(year: 2024, week: 1, tasks: [MockDayTasksList(date: Date.startDateOfWeek(2024, 1)!, tasks: [MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask()])]),
            MockWeekTasksList(year: 2024, week: 2, tasks: [MockDayTasksList(date: Date.startDateOfWeek(2024, 2)!, tasks: [MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask()])]),
            MockWeekTasksList(year: 2024, week: 3, tasks: [MockDayTasksList(date: Date.startDateOfWeek(2024, 3)!, tasks: [MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask()])]),
            MockWeekTasksList(year: 2024, week: 4, tasks: [MockDayTasksList(date: Date.startDateOfWeek(2024, 4)!, tasks: [MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask(),MockTask()])])
        ]
        return weeklyTasksArr
    }
}


extension MockData {
    private static func createTask(_ dayOffset: Int,_ tag: TaskTag) -> MockTask {
        var mockTask: MockTask = MockTask()
        let calendar = Calendar.current
        if let day = calendar.date(byAdding: .day, value: -dayOffset, to: Date()) {
            let startTime = calendar.date(byAdding: .hour, value: 1, to: calendar.startOfDay(for: day)) ?? Date()
            let endTime = calendar.date(byAdding: .hour, value: 2, to: calendar.startOfDay(for: day)) ?? startTime
            mockTask = MockTask(addedTime: day, startTime: startTime, endTime: endTime, tag: tag)
        }
        return mockTask
    }
}



extension MockData {
    static var averageCount = 7
}

/// TagStatsView
enum TaskTag: String, Identifiable, CaseIterable{
    var id: Self { return self }
    
    case red = "TaskColor1"
    case blue = "TaskColor2"
    case yello  = "TaskColor3"
    case pink  = "TaskColor4"
    case gray  = "TaskColor5"
    case black  = "TaskColor6"
}

struct MockTagTask {
    var id = UUID()
    var tag: TaskTag
    var count: Int
}



