//
//  TasksScreenView.swift
//  Pomotron
//
//  Created by Ge Ding on 2/13/24.
//

import SwiftUI

struct TasksScreenView: View {
    @State private var currentDay: Date = .init()
    @State private var presentWeekRow: Bool = true
    @Environment(\.managedObjectContext) private var moc
    
    // Souce of Truth
    var tasks = MockData.mockAllTasksArr
    var body: some View {
        HeaderView()
        WeekRowView()
        TaskListView()
    }
}

#Preview {
    TasksScreenView()
}

extension TasksScreenView {
    @ViewBuilder
    func HeaderView() -> some View {
        VStack {
            HStack{
                VStack(alignment: .leading) {
                    Text("Today")
                    
                    Text("Welcome,Simon")
                }
                .foregroundStyle(Color.gray)
                .hAlign(.leading)
                .padding(.horizontal,3)
                
                Button {
                    presentWeekRow.toggle()
                } label: {
                    HStack(spacing:10) {
                        Image(systemName: "plus")
                        Text("Add Task")
                        
                    }
                    .foregroundStyle(Color.white)
                    .padding(.vertical,10)
                    .padding(.horizontal,15)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    @ViewBuilder
    func WeekRowView() -> some View {
        HStack(spacing: 0) {
            VStack(spacing: 10) {
                Text(Calendar.current.currentWeek[0].date.format("MMM"))
            }
            .foregroundStyle(Color.gray)
            
            ForEach(Calendar.current.currentWeek) { weekday in
                let status = Calendar.current.isDate(weekday.date, inSameDayAs: currentDay)
                VStack(spacing: 6) {
                    Text(weekday.date.format("E"))
                    Text(weekday.date.format("dd"))
                }
                .foregroundStyle(status ? Color.blue : Color.gray)
                .hAlign(.center)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentDay = weekday.date
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
    }
    
    @ViewBuilder
    func TaskListView() -> some View {
        ScrollView {
            ForEach(filterTasks(currentDay)) { task in
                TaskCardView(task: task)
            }
        }
        .padding()
    }
}


extension TasksScreenView {
    //filter task
    func filterTasks(_ date: Date) -> [MockTask] {
        
        return tasks.filter { $0.startTime.isSameDate(date) }
    }
}

