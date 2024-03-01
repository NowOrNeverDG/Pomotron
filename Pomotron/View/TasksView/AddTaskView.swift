//
//  AddTaskView.swift
//  Pomotron
//
//  Created by Ge Ding on 2/27/24.
//

import SwiftUI

struct AddTaskView: View {
    
    var onAdd: (Task) -> ()
    @State private var title = ""
    @State private var startDate: Date = .now
    @State private var endDate: Date = .now
    @State var tagColor: TaskTag = .black
    
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
                .padding(.vertical)

            TimeSettingCellView("Satrt Date", startDate)
            TimeSettingCellView("End Date", endDate)
            
            Divider()
                .padding(.vertical)

            HStack(alignment: .center, spacing: 15) {
                ForEach(TaskTag.allCases) { taskTag in
                    Button {
                        tagColor = taskTag
                    } label: {
                        Circle()
                            .fill(Color(taskTag.rawValue))
                            .frame(width:25, height:25)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .environment(\.colorScheme,.dark)
        .hAlign(.leading)
        .padding(15)
        .background {
            Color(tagColor.rawValue)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.2), value: tagColor.rawValue)
        }
    }
    
    @ViewBuilder
    func TimeSettingCellView(_ title: String,_ date: Date) -> some View {
        VStack(alignment: .leading) {
            Text(title)
            HStack(alignment: .bottom, spacing: 12) {
                HStack(spacing: 12) {
                    Text(date.format("EEEE dd, MMMM"))
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
                    Text(date.format("HH:mm"))
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
        }
        
        
    }
}

#Preview {
    AddTaskView { task in
        
    }
}
