//
//  ReocrdViewModel.swift
//  Pomotron
//
//  Created by Ge Ding on 9/18/23.
//

import Foundation
import CoreData
import CloudKit

final class RecordViewModel: ObservableObject {
    @Published var records = [Record]()
    var coreDataManager: CoreDataManager<Record>
    
    init(_ coreDataManager: CoreDataManager<Record>)  {
        self.coreDataManager = coreDataManager
        fetchRecords()
    }

    func fetchRecords() {
        do {
            records = try coreDataManager.fetchAllObjects()
        } catch {
            print("Error fetching records: \(error)")
        }
    }
    
    func addRecord(_ record: Record) {
        do {
            try coreDataManager.addObject(record)
            try coreDataManager.saveContext()
            records = try coreDataManager.fetchAllObjects()
        } catch {
            print("Error adding record: \(error)")
        }
    }
}
