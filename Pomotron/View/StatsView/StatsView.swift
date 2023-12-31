//
//  StatsView.swift
//  Pomotron
//
//  Created by Ge Ding on 11/26/23.
//

import SwiftUI
import Charts

struct StatsView: View {

    
    @Environment(\.colorScheme) var scheme

    @State private var statsType: StatsType = .PomoStats
    @State private var rawSelectedDate: Date? = nil

    @State private var pressDayCount = 0
    @State private var pressWeekCount = 0
    
    var body: some View {
        /// Statistic View
        //title: 月pomo总数，周pomo总数，日pomo总数
        
        //title: 默认最高pomo的time和量 + 摸了指定day的pomo和量
        //每日完成pomo的量
        
        //title: 默认最高pomo的day和量 + 摸了指定day的pomo的day和量
        //每周完成pomo的量
        
        //title: 默认最高pomo的数和量， 摸了指定pomo的数和量
        //pomo tag分布 barmark3
        
        //title: 默认最高周pomo的数和量，摸了指定周pomo的数和量
        //从这周起往前，向前一共八周的周pomo的数和量
            VStack {
                /// Segmneted Picker
                PickerView()
                SumView()
                DayStatsView()
                WeekStatsView()
            }
            .padding()
    }
    
    @ViewBuilder
    func PickerView() -> some View {
        Picker("", selection: $statsType) {
            ForEach(StatsType.allCases, id: \.rawValue) {
                Text($0.rawValue)
                    .tag($0)
            }
        }
        .pickerStyle(.segmented)
        .labelsHidden()
    }
    
    @ViewBuilder
    func SumView() -> some View {
        HStack {
            VStack {
                Text("月 POMO")
                Text("\(MockData.mockMonthlyTasksCount)")
            }
            Spacer()
            VStack {
                Text("周 POMO")
                Text("\(MockData.mockWeeklyTasksCount)")
            }
            Spacer()
            VStack {
                Text("日 POMO")
                Text("\(MockData.mockDailyTasksCount)")
            }
        }
        .fontWeight(.semibold)
        .foregroundColor(.gray)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill((scheme == .dark ? Color.black : Color.white).shadow(.drop(radius: 2)))
        }
    }
    
    @ViewBuilder
    func DayStatsView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Count: \(pressWeekCount)")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                
            Chart(MockData.mockDayTasksCountInRecentMonth, id:\.0) { dayTasks in
                LineMark(x: .value("Date", dayTasks.0),
                         y: .value("Pomo", dayTasks.1))
                .interpolationMethod(.monotone)
            }
            .foregroundStyle(.green)
            .chartScrollableAxes(.horizontal)
            .chartYScale(domain: [0,10])
            //.chartXVisibleDomain(length: 5)
            .chartYAxis {
                AxisMarks(values:[0,4,8])
            }
            .chartXAxis {
                AxisMarks(stroke: StrokeStyle(lineWidth: 0))
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill((scheme == .dark ? Color.black : Color.white).shadow(.drop(radius: 2)))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    func WeekStatsView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Count: \(pressWeekCount)")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
    
            Chart(MockData.mockWeeklyTasksArr, id: \.id) {
                BarMark(x: .value("Week", $0.startDate),
                        y: .value("Count", $0.count)
                )
                .opacity(rawSelectedDate == nil || rawSelectedDate == $0.startDate ? 1 : 0.5)
                .foregroundStyle(Color(.blue).gradient)
                .interpolationMethod(.catmullRom)

                
                RuleMark(y: .value("Average", MockData.averageCount))
                    .foregroundStyle(Color(.green).gradient)
                    .annotation(position: .top,
                                alignment: .topTrailing) {
                        Text("Average: \(MockData.averageCount)")
                            .foregroundStyle(Color(.green).gradient)
                    }
                
                if let rawSelectedDate = rawSelectedDate {
                    RuleMark(x: .value("Selected", rawSelectedDate))
                    .foregroundStyle(Color.gray.opacity(0.1))
                    .annotation ( position: .top) {
                        Text("Hello")
                            .padding(6)
                            .background {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.white)
                                    .shadow(color: .blue, radius: 2)
                            }
                    }
                }
            }
            .chartXSelection(value: $rawSelectedDate)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill((scheme == .dark ? Color.black : Color.white).shadow(.drop(radius: 2)))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

    }
}

#Preview {
    StatsView()
}
