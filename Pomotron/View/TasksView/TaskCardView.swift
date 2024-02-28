//
//  TaskBlockView.swift
//  Pomotron
//
//  Created by Ge Ding on 2/20/24.
//

import SwiftUI

struct TaskCardView: View {
    var task: MockTask
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Text(task.startTime.format("hh:mm"))
                    .font(.title2.bold())
                Text(task.endTime.format("hh:mm"))
                    .font(.title2.bold())
            }
            
            VStack {
                Text(task.title)
                    .font(.title2.bold())
            }
        }
        .foregroundColor(.white)
        .padding()
        .hLeading()
        .background{
            Color("\(task.tag.rawValue)")
                .cornerRadius(25)
        }
    }
}


#Preview {
    TaskCardView(task: MockTask())
}
