//
//  AddTaskView.swift
//  Pomotron
//
//  Created by Ge Ding on 2/27/24.
//

import SwiftUI

struct AddTaskView: View {
    
//    var onAdd: (Task) -> ()
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var startDate: Date = .now
    @State private var endDate: Date = .now
    @State private var tagColor: TaskTag = .black
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Create New Task")
                .foregroundStyle(.white)
                .padding(.vertical, 15)
            
            Text("Title")
            TextField("Create your title", text: $title)
                .tint(.white)
                .padding(.top,2)
            
            Divider()
                .background(.white)
            
            Text("Start Time")
            HStack(alignment: .bottom, spacing: 12) {
                HStack(spacing: 12) {
                    Text(startDate.format("EEEE dd, MMMM"))
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(.white)
                        .overlay {
                            //Start Date Picker
                        }
                }
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(height: 0.7)
                        .offset(y:5)
                }
                
                HStack(spacing: 12) {
                    Text(startDate.format("HH:mm"))
                    Image(systemName: "clock")
                        .font(.title3)
                        .foregroundColor(.white)
                        .overlay {
                            //Start Time Picker
                        }
                }
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(height: 0.7)
                        .offset(y:5)
                }
            }
            Text("End Time")
            HStack(alignment: .bottom, spacing: 12) {
                HStack(spacing: 12) {
                    Text(startDate.format("EEEE dd, MMMM"))
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(.white)
                        .overlay {
                            //End Date Picker
                        }
                }
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(height: 0.7)
                        .offset(y:5)
                }
                
                HStack(spacing: 12) {
                    Text(startDate.format("HH:mm"))
                    Image(systemName: "clock")
                        .font(.title3)
                        .foregroundColor(.white)
                        .overlay {
                            //End Time Picker
                        }
                }
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(height: 0.7)
                        .offset(y:5)
                }
            }
            
        }
        .environment(\.colorScheme,.dark)
        .hAlign(.leading)
        .padding(15)
        .background {
            Color(tagColor.rawValue)
                .ignoresSafeArea()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                ForEach(TaskTag.allCases) { taskTag in
                    Button {
                        tagColor = taskTag
                    } label: {
                        Circle()
                            .frame(width:25, height:25)
                            .backgroundStyle(Color(taskTag.rawValue))
                    }

                    
                }
            }
        }
    }
    
}

#Preview {
    AddTaskView()
}
