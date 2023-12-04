//
//  StatsView.swift
//  Pomotron
//
//  Created by Ge Ding on 11/26/23.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    @State var statsType: StatsType = .PomoStats
    
    var body: some View {
        /// Segmneted Picker
        PickerView()
        
        /// Statistic View
        if statsType == .PomoStats {
            
        } else {
            
        }
        

        
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
    func PomoStatsView() -> some View {
        //title: 月pomo总数，周pomo总数，日pomo总数
        
        //title: 默认最高pomo的time和量 + 摸了指定day的pomo和量
        //每日完成pomo的量
        
        //title: 默认最高pomo的day和量 + 摸了指定day的pomo的day和量
        //每周完成pomo的量
        
        //title: 默认最高pomo的数和量， 摸了指定pomo的数和量
        //pomo tag分布 barmark3
        
        //title: 默认最高周pomo的数和量，摸了指定周pomo的数和量
        //从这周起往前，向前一共八周的周pomo的数和量
    }
}

#Preview {
    StatsView()
}
