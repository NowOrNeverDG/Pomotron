//
//  DailyTasks+CoreDataProperties.swift
//  Pomotron
//
//  Created by Ge Ding on 2/27/24.
//
//

import Foundation
import CoreData


extension DailyTasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyTasks> {
        return NSFetchRequest<DailyTasks>(entityName: "DailyTasks")
    }

    @NSManaged public var id: String?
    @NSManaged public var date: Date?
    @NSManaged public var tasks: NSSet?
    
    public var unwrapped_id: String {
        id ?? ""
    }
    
    public var unwrapped_date: Date {
        date ?? .now
    }
    
    public var unwrapped_tasks: [Task] {
        let set = tasks as? Set<Task> ?? []
        return set.sorted { $0.unwrapped_start_date < $1.unwrapped_start_date }
    }

}

// MARK: Generated accessors for task
extension DailyTasks {

    @objc(addTaskObject:)
    @NSManaged public func addToTask(_ value: Task)

    @objc(removeTaskObject:)
    @NSManaged public func removeFromTask(_ value: Task)

    @objc(addTask:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTask:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension DailyTasks : Identifiable {

}
