//
//  LaunchScreenManager.swift
//  Pomotron
//
//  Created by Ge Ding on 2/12/24.
//

import Foundation

enum LaunchScreenPhase {
    case first
    case second
    case completed
}

final class LaunchScreenManager: ObservableObject {
    @Published private(set) var state: LaunchScreenPhase = .first
    
    func dismiss() {
        self.state = .second
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.state = .completed
        }
    }
}
