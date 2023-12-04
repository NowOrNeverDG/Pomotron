//
//  ContentView.swift
//  Pomotron
//
//  Created by Ge Ding on 9/14/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            TasksView()
                .tabItem { Label("Tasks", systemImage: "book.circle.fill") }
            StatsView()
                .tabItem { Label("Stats", systemImage: "doc") }
        }
        
    }
}

#Preview {
    ContentView()
}
