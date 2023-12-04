//
//  TasksView.swift
//  Pomotron
//
//  Created by Ge Ding on 11/30/23.
//

import SwiftUI

struct TasksView: View {
    @State private var currentDate: Date = .init()
    @State private var weekSelected: Int = 1
    @State private var daySelected: Date = .init()
    @State private var weekArr:[[WeekDay]] = MockData.mockWeekDayArr

    @Namespace private var animation
    
    var body: some View {
        VStack {
            DateRowView()
                .frame(maxHeight: 50)
            WeekSliderView()
                .frame(maxHeight: 50)
                
            
            
            Spacer()
        }
        .padding()
        .hSpacing(.leading)
    }
}

extension TasksView {
    /// Header view
    @ViewBuilder
    func DateRowView() -> some View {
        VStack {
            HStack(spacing: 6) {
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(.gray)
                Text(currentDate.format("dd"))
                    .foregroundStyle(.gray)
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.gray)

                Spacer()
                
                Text(currentDate.format("EEEE"))
                    .foregroundStyle(.gray)
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func WeekSliderView() -> some View {
        HStack(spacing: 1) {
            TabView(selection: $weekSelected) {
                ForEach(weekArr.indices, id: \.self) { index in
                    WeekRowView(weekArr[index])
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
    @ViewBuilder
    func WeekRowView(_ week: [WeekDay]) -> some View {
        HStack {
            ForEach(week) { day in
                VStack {
                    Group {
                        Text(day.date.format("E"))
                        Text(day.date.format("dd"))
                    }
                    .font(.callout)
                    .fontWeight(.medium)
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            daySelected = day.date
                        }
                    }
                }
                .hSpacing(.center)
                .contentShape(.rect)
                .background {
                    if day.date.isSameDate(daySelected) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray)
                            .opacity(0.2)
                            .frame(width: 50, height: 50)
                            .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                    }
                }
            }
        }
    }
    
    
}

#Preview {
    TasksView()
}
