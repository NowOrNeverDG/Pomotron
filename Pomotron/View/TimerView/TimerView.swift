//
//  TimerView.swift
//  Pomotron
//
//  Created by Ge Ding on 2/4/24.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.colorScheme) var scheme

    @State private var timeRemaining: TimeInterval = 1500
    @State private var timer: Timer?
    @State private var isRunning: Bool = false
    @State private var pinnedTodo: String = "None Todo pinned"
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                ZStack {
                    Circle()
                        .trim(from: 0,to:1)
                        .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap:.round))
                        .opacity(0.3)
                        .padding()
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(1-(timeRemaining) / 10))
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                    
                    Text(formattedTime())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                }
                .frame(maxWidth: 500)
                
                HStack {
                    Button {
                        isRunning.toggle()
                        if isRunning {
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    } label: {
                        Image(systemName: isRunning ? "stop.fill" : "play.fill")
                            .foregroundStyle(.foreground)
                            .frame(width: 50, height: 50)
                            .font(.largeTitle)
                            .padding()
                    }
                }
                
                HStack {
                    Image(systemName: "pin.fill")
                        .padding()
                    Spacer()
                    Text("Working with old Torb for xxxxxxxxx xxx xxx xxxx xxxx")
                        .padding()
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill((scheme == .dark ? Color.black : Color.white).shadow(.drop(radius: 2)))
                        .frame(height:100)
                        .frame(maxWidth: .infinity)
                }
                .padding(.vertical)
            }
            .padding(.horizontal, 30)
        }
    }
    
    private func formattedTime() -> String {
        let minutes = Int(timeRemaining) / 60
        let second = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes,second)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        })
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timeRemaining = 1500
        isRunning = false
    }
}

#Preview {
    TimerView()
}
