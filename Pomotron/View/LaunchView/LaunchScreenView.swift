//
//  LaunchScreenView.swift
//  Pomotron
//
//  Created by Ge Ding on 2/12/24.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    private let timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
    
    @State private var firstPhaseIsAnimating: Bool = false
    @State private var secondPhaseIsAniamting: Bool = false
    
    var body: some View {
        ZStack {
            background
            logo
        }
        .onReceive(timer) { input in
            withAnimation(.spring()) {
                switch launchScreenManager.state {
                case .first:
                    withAnimation(.spring()) {
                        firstPhaseIsAnimating.toggle()
                    }
                case .second:
                    withAnimation(.easeInOut) {
                        secondPhaseIsAniamting.toggle()
                    }
                default: break
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
        .environmentObject(LaunchScreenManager())
}

private extension LaunchScreenView {
    var background: some View {
        Color("launch-screen-background")
            .edgesIgnoringSafeArea(.all)
    }
    
    var logo: some View {
        Image("logo")
            .scaleEffect(firstPhaseIsAnimating ? 0.6 : 1)
            .scaleEffect(secondPhaseIsAniamting ? UIScreen.main.bounds.size.height / 4 : 1)
    }
}
