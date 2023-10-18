//
//  Color+Extension.swift
//  Pomotron
//
//  Created by Ge Ding on 9/16/23.
//
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255.0,
            green: Double((hex >> 8) & 0xff) / 255.0,
            blue: Double(hex & 0xff) / 255.0,
            opacity: alpha
        )
    }
}

extension Color {
    static let lavenderPurple = Color(hex: 0xCABBE9)
    static let pastelPink = Color(hex: 0xFFCEF3)
    static let nearlyWhite = Color(hex: 0xFDFDFD)
    static let vibrantOrange = Color(hex: 0xFF9F68)
    
    ///Task view Color
    static let taskBlue = Color("TaskColorBlue")
    static let taskGray = Color("TaskColorGray")
    static let taskPink = Color("TaskColorPink")
    static let taskYellow = Color("TaskColorYellow")
    static let taskWhite = Color("TaskColorBlue")
}

