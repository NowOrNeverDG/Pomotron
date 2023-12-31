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
            StatsView()
                .tabItem { Label("Stats", systemImage: "doc") }
            TasksView()
                .tabItem { Label("Tasks", systemImage: "book.circle.fill") }
            
        }
        
    }
}

#Preview {
    ContentView()
}
