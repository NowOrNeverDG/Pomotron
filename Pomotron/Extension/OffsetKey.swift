//
//  OffsetKey.swift
//  Pomotron
//
//  Created by Ge Ding on 9/28/23.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
