//
//  PomotronApp.swift
//  Pomotron
//
//  Created by Ge Ding on 9/14/23.
//

import SwiftUI

@main
struct PomotronApp: App {
    
    @StateObject var launchScreenManager = LaunchScreenManager()
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                if launchScreenManager.state != .completed { LaunchScreenView() }
            }
        }
        .environmentObject(launchScreenManager)
    }
}
