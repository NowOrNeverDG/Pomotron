//
//  NewTaskView.swift
//  Pomotron
//
//  Created by Ge Ding on 9/30/23.
//

import SwiftUI

struct NewTaskView: View {
    /// View properties
    @Environment(\.dismiss) private var dismiss
    /// Model context for saving date
    @Environment(\.modelContext) private var context
    
    /// Task Details
    @State private var taskTitle: String = ""
    @State private var taskCreationDate: Date = .init()
    @State private var taskStartDate: Date = .init()
    @State private var taskEndDate: Date = .init()
    @State private var taskTags: [String] = []
    @State private var taskColor: String = "TaskColor 1"

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ///Closed New Task
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .tint(.red)
            }
            .hSpacing(.leading)
            
            ///Task Title
            VStack(alignment: .leading, spacing: 8) {
                Text("Task Title")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                TextField("", text: $taskTitle)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
            }
            .padding(.top, 5)
            
            /// Data Picker & Color Selection Pack
            HStack(spacing: 12) {
                VStack {
                    /// Stack Time
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Start Time")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        DatePicker("", selection: $taskStartDate)
                            .datePickerStyle(.compact)
                            .scaleEffect(0.9, anchor: .leading)
                    }
                    .padding(.trailing, -15)
                    
                    /// End Time
                    VStack(alignment: .leading, spacing: 8) {
                        Text("End Time")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        DatePicker("", selection: $taskEndDate)
                            .datePickerStyle(.compact)
                            .scaleEffect(0.9, anchor: .leading)
                    }
                    .padding(.trailing, -15)
                }
                
                /// Color selection
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Color")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    let colors: [String] = (1...5).compactMap { index -> String in
                        return "TaskColor \(index)"
                    }                    
                    HStack(spacing: 0) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(Color(color))
                                .frame(width: 20, height: 20)
                                .background(content: {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .opacity(taskColor == color ? 1 : 0)
                                })
                                .hSpacing(.center)
                                .contentShape(.rect)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        taskColor = color
                                    }
                                }
                        }
                    }
                }
            }                
            .padding(.top, 5)

            Spacer(minLength: 0)
            
            /// Saving Task
            Button(action: {
                let task = Task(title: taskTitle, startDate: taskStartDate, endDate: taskEndDate, tint: taskColor)
                do {
                    context.insert(task)
                    try context.save()
                    /// After Successful Task Creation, Dismissing the view
                    dismiss()
                } catch {
                    print("[New Task View] Saving Task Error: \(error.localizedDescription)")
                }
            }, label: {
                Text("Creat Task")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(Color(taskColor), in: .rect(cornerRadius:10))
            })
            .disabled(taskTitle == "")
            .opacity(taskTitle == "" ? 0.5 : 1)
        }
        .padding(20)
    }
}

#Preview {
    NewTaskView()
        .vSpacing(.bottom)
}
