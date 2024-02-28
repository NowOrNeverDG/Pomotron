//
//  WeeklyTasks+CoreDataProperties.swift
//  Pomotron
//
//  Created by Ge Ding on 2/27/24.
//
//

import Foundation
import CoreData


extension WeeklyTasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeeklyTasks> {
        return NSFetchRequest<WeeklyTasks>(entityName: "WeeklyTasks")
    }

    @NSManaged public var id: String?
    @NSManaged public var year: Int16
    @NSManaged public var week: Int16
    @NSManaged public var daily_tasks: NSSet?
    
    public var unwrapped_id: String {
        id ?? ""
    }
    
    public var unwrapped_daily_tasks: [DailyTasks] {
        let set = daily_tasks as? Set<DailyTasks> ?? []
        return set.sorted { $0.unwrapped_date < $1.unwrapped_date }
    }
}

// MARK: Generated accessors for daily_tasks
extension WeeklyTasks {

    @objc(addDaily_tasksObject:)
    @NSManaged public func addToDaily_tasks(_ value: DailyTasks)

    @objc(removeDaily_tasksObject:)
    @NSManaged public func removeFromDaily_tasks(_ value: DailyTasks)

    @objc(addDaily_tasks:)
    @NSManaged public func addToDaily_tasks(_ values: NSSet)

    @objc(removeDaily_tasks:)
    @NSManaged public func removeFromDaily_tasks(_ values: NSSet)

}

extension WeeklyTasks : Identifiable {

}
