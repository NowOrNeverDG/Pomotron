//
//  PomotronApp.swift
//  Pomotron
//
//  Created by Ge Ding on 9/14/23.
//

import SwiftUI

@main
struct PomotronApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
