//
//  TimerView.swift
//  Pomotron
//
//  Created by Ge Ding on 9/14/23.
//

import SwiftUI
import CoreData

struct TimerView: View {
    @StateObject var timeVM = TimerViewModel()
    @ObservedObject var recordVM : RecordViewModel
    @State private var isShowingEventInput = false

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Circle()
                        .stroke(Color.vibrantOrange, lineWidth: 30)
                        .padding(70)
                    
                    VStack {
                        if timeVM.isActive {
                            Text("\(timeVM.time)")
                                .font(.system(size: 70, weight: .medium, design: .rounded))
                                .padding()
                        } else {
                            Text("Start")
                                .font(.system(size: 70, weight: .medium, design: .rounded))
                                .padding()
                        }
                        
                    }.onReceive(timer) { _ in
                        timeVM.updateCountdown()
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color.vibrantOrange)
                        .shadow(radius: 5)
                        .ignoresSafeArea()
                    
                    VStack {
                        NavigationView {
                            List(recordVM.records, id: \.self) { record in
                                Text(record.title ?? "No NAME")
                            }
                            .navigationBarTitle("Records")
                            .navigationBarItems(trailing: addButton)
                        }
                    }
                }
            }
        }
    }
    
    var addButton: some View {
            Button(action: {
                isShowingEventInput.toggle()
            }) {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $isShowingEventInput) {
                RecordInputView(isPresented: $isShowingEventInput)
            }
        }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        let coreDataManager = CoreDataManager<Record>(NSPersistentContainer(name: "Pomotron"))
        let viewModel = RecordViewModel(coreDataManager)
        TimerView(timeVM: TimerViewModel(), recordVM: viewModel)
    }
}
