//
//  ContentView.swift
//  Pomotron
//
//  Created by Ge Ding on 9/14/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let coreDataManager = CoreDataManager<Record>(NSPersistentContainer(name: "Pomotron"))
    
    var body: some View {
        let viewModel = RecordViewModel(coreDataManager)
        TimerView(timeVM: TimerViewModel(), recordVM: viewModel)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
