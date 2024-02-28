//
//  Task+CoreDataProperties.swift
//  Pomotron
//
//  Created by Ge Ding on 2/27/24.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: String?
    @NSManaged public var start_date: Date?
    @NSManaged public var end_date: Date?
    @NSManaged public var added_date: Date?
    @NSManaged public var tag_color: String?
    @NSManaged public var title: String?
    @NSManaged public var daily_tasks: DailyTasks?
    
    public var unwrapped_id: String {
        id ?? ""
    }
    
    public var unwrapped_start_date: Date {
        start_date ?? .now
    }
    
    public var unwrapped_end_date: Date {
        end_date ?? .now
    }
    
    public var unwrapped_added_date: Date {
        added_date ?? .now
    }
    
    public var unwrapped_tag_color: String {
        tag_color ?? "TaskColor1"
    }
    
    public var unwrapped_title: String {
        title ?? ""
    }
    
    

}

extension Task : Identifiable {

}
