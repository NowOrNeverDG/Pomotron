//
//  StatsView.swift
//  Pomotron
//
//  Created by Ge Ding on 11/26/23.
//

import SwiftUI
import Charts

struct StatsView: View {
    @State var statsType: StatsType = .PomoStats
    
    
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
                .frame(maxHeight:100)
            
            DayStatsView()
                .frame(maxHeight: 150)
            
            WeekStatsView()
                .frame(maxHeight: 150)

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
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 1)
            
            HStack {
                VStack {
                    Text("月 POMO")
                    Text("120")
                }
                Spacer()
                VStack {
                    Text("周 POMO")
                    Text("40")
                }
                Spacer()
                VStack {
                    Text("日 POMO")
                    Text("8")
                }
            }
            .padding()
        }

    }
    
    @ViewBuilder
    func DayStatsView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .stroke(lineWidth: 1)
            
            VStack {
                Chart(Array(MockData.mockTasksDic.keys).sorted().reversed(), id: \.self) { index in
                    LineMark(x: .value("日期", index.format("dd MMM")),
                             y: .value("Pomo数", MockData.mockTasksDic[index]?.count ?? 0))
                    .interpolationMethod(.monotone)
                }
                .foregroundStyle(.green)
                .chartScrollableAxes(.horizontal)
                .chartYScale(domain: [0,10])
                .chartXVisibleDomain(length: 5)
                .chartYAxis {
                    AxisMarks(values:[0,4,8,12])
                }
                .chartXAxis {
                    AxisMarks(stroke: StrokeStyle(lineWidth: 0))
                }
                .frame(maxHeight: 90)
                .padding(.top)
            }
        }
    }
    
    @ViewBuilder
    func WeekStatsView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .stroke(lineWidth: 1)
            
            VStack {
            }
        }
    }
}

#Preview {
    StatsView()
}
