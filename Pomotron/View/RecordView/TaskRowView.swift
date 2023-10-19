//
//  TaskRowView.swift
//  Pomotron
//
//  Created by Ge Ding on 9/30/23.
//

import SwiftUI

struct TaskRowView: View {
    @Bindable var task: Task
    /// Model Context
    @Environment(\.modelContext) private var context
    
    @State private var taskTitle: String = ""
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .fill(indicatorlColor)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
                .overlay {
                    Circle()
                        .foregroundStyle(.clear)
                        .contentShape(.circle)
                        .frame(width: 50, height:  50)
                }
            
            //Showed Task Title
            VStack(alignment: .leading, spacing: 8) {
                TextField("Task Title", text: $taskTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .onSubmit {
                        /// If TaskTitle is Empty, Then Deleting the Task!
                        /// You can remove this feature, if you don't want to delete the Task even after the TextField is Empty
                        if taskTitle == "" {
                            context.delete(task)
                            try? context.save()
                        }
                    }
                    .onChange(of: taskTitle, initial: false) { oldValue, newValue in
                        task.title = newValue
                    }
                    .onAppear {
                        if taskTitle.isEmpty {
                            taskTitle = task.title
                        }
                    }
                
                Text("\(task.creationDate.format("hh:mm a")) - \(task.creationDate.format("hh:mm a"))")
                    .font(.caption)
                    .foregroundStyle(.black)
                
            }
            .padding(15)
            .hSpacing(.leading)
            .background(task.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .contentShape(.contextMenuPreview, .rect(cornerRadius: 15))
            .contextMenu {
                Button("Delete Task", role: .destructive) {
                    /// Deleting Task
                    context.delete(task)
                    try? context.save()
                }
                .offset(y: -8)
            }
        }
    }
    
    var indicatorlColor: Color {
        return task.creationDate.isSameHour ? .blue : (task.creationDate.isPast ? .red : .black)
    }
}

#Preview {
    ContentView()
}
