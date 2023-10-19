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
            RecordView()
                .tabItem { Label("Task", systemImage: "doc") }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}
