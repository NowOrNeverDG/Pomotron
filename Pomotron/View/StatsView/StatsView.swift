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
    
    var body: some View {
        /// Statistic View
        //月pomo总数，周pomo总数，日pomo总数
        //最近28天的时间内，每日的pomo量：线形图，可拉拽
        //最近7天的时间，每日的pomo量：柱状图
        //最近4周的时间，每周的pomo量：柱状图
        //最近4周的时间，每个时段的pomo量：柱状图
        //最近28天的时间内，tag的分布：饼状图
        VStack {
            PickerView()
                .padding()

            ScrollView {
                VStack {
                    /// Segmneted Picker
                    SumView()
                    Recent28DaysDailyStatsView()
                    Recent7DaysDailyStatsView()
                    Recent4WeeksWeeklyStatsView()
                    TagStatsView()
                }
                .padding()
            }
        }
        
    }
    
    @ViewBuilder
    private func PickerView() -> some View {
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
    private func SumView() -> some View {
        HStack {
            VStack {
                Text("Mothly")
                Text("\(MockData.mockMonthlyTasksCount)")
            }
            Spacer()
            VStack {
                Text("Weekly")
                Text("\(MockData.mockWeeklyTasksCount)")
            }
            Spacer()
            VStack {
                Text("Daily")
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
    private func Recent28DaysDailyStatsView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("最近28天: \(MockData.mockRecent28DaysTasks.totalCount)")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Chart(MockData.mockRecent28DaysTasks.recentDaysTasksArr) {
                LineMark(x: .value("Date", $0.date),
                         y: .value("Pomo", $0.taskCount))
                .interpolationMethod(.monotone)
            }
            .foregroundStyle(.green)
            .chartScrollableAxes(.horizontal)
            .chartXAxis { AxisMarks(stroke: StrokeStyle(lineWidth: 0)) }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill((scheme == .dark ? Color.black : Color.white).shadow(.drop(radius: 2)))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    private func Recent7DaysDailyStatsView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("最近7天: \(MockData.mockRecent7DaysTasks.totalCount)")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Chart(MockData.mockRecent7DaysTasks.recentDaysTasksArr) {
                BarMark(x: .value("Day", $0.date.format("d/M")),
                        y: .value("Count", $0.taskCount))
                .foregroundStyle(Color(.blue).gradient)
                .interpolationMethod(.catmullRom)

                RuleMark(y: .value("Average", MockData.mockRecent7DaysTasks.average))
                    .foregroundStyle(Color(.green).gradient)
                    .annotation(position: .top,
                                alignment: .topTrailing) {
                        Text("Avg: "+String(format: "%.1f", MockData.mockRecent7DaysTasks.average))
                            .foregroundStyle(Color(.green).gradient)
                    }
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
    private func Recent4WeeksWeeklyStatsView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("最近4周：")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Chart(MockData.mockRecent4WeeksWeeklyTasksArr) {
                BarMark(x: .value("Week", $0.dateRange),
                        y: .value("WeekTaskCount", $0.tasksCount))
                .foregroundStyle(Color(.blue).gradient)
                .interpolationMethod(.catmullRom)
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
    private func TagStatsView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent 28 Days:")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Chart(MockData.mockTagCountPairArr) {
                BarMark(x: .value("tagCount", $0.tagCount))
                    .foregroundStyle(by: .value("Tag", $0.tag.rawValue))

            }
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
