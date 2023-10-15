//
//  CoreDataManager.swift
//  Pomotron
//
//  Created by Ge Ding on 9/18/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager<T:NSManagedObject> {
    private(set) var container: NSPersistentContainer
    
    init(_ container: NSPersistentContainer) {
        self.container = container
        self.container.loadPersistentStores { (description, error) in
            if let error = error{
                print("ERROR: Loading Core Data \(error)")
            } else {
                print("Successfully loaded Core Data!")
            }
        }
    }
    
    // Fetch all objects of type T from Core Data asynchronously
    func fetchAllObjects() throws -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        do {
            let objects = try self.container.viewContext.fetch(request)
            return objects
        } catch {
            throw error
        }
    }
    
    func addObject(_ object: T) throws {
        container.viewContext.insert(object)
    }
    
    func saveContext() throws {
        do {
            try container.viewContext.save()
        } catch {
            throw error
        }
    }
}
