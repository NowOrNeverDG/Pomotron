//
//  ContentView.swift
//  Pomotron
//
//  Created by Ge Ding on 9/14/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    
    var body: some View {
        TabView {
            AddTaskView()
                .tabItem { Label("Tasks", systemImage: "book.circle.fill") }
            StatsView()
                .tabItem { Label("Stats", systemImage: "doc") }
            SettingView()
                .tabItem { Label("Setting", systemImage: "gear") }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                launchScreenManager.dismiss()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LaunchScreenManager())
}
