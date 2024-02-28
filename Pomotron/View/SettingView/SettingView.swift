//
//  SettingView.swift
//  Pomotron
//
//  Created by Ge Ding on 1/30/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView{
            List {
                PremiumSection()
                SystemSettingSection()
                PromoSettingSection()
                LogoutSection()
            }
        }
    }
    
    @ViewBuilder
    func PremiumSection() -> some View {
        Section("Account") {
            ZStack {
                Color.BG

                Button {
                    print("Image tapped!")
                } label: {   
                    Image("Premium")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            
        }
        .frame(height: 100)
    }
    
    @State var fontSize: FontSize = .sizeM
    @State var backgroundSkin: BackgroundSkin = .system
    
    @ViewBuilder
    func SystemSettingSection() -> some View {
        let fontOptions = FontSize.allCases
        let backgroundSkinOptions = BackgroundSkin.allCases
        Section("System Setting") {
            PickerButtonCell(label: "Font", val: $fontSize, options: fontOptions)
            PickerButtonCell(label: "Background", val: $backgroundSkin, options: backgroundSkinOptions)
        }
    }
    
    @State var promoDur: TimeDur = .min30
    @State var restDur: TimeDur = .min5
    @State var longRestDur: TimeDur = .min30
    @State var isVibrable: Bool = false
    @State var longRestInterval: Int = 4
    @State var ticking: Bool = false
    @State var endingReminder = false
    @ViewBuilder
    func PromoSettingSection() -> some View {
        let promoDurOptions: [TimeDur] = [.min25,.min30,.min35,.min40,.min45,.min50,.min55,.min60]
        let restDurOptions: [TimeDur] = TimeDur.allCases
        let longRestDurOptions: [TimeDur] = TimeDur.allCases
        let longRestIntervalOptions: [Int] = Array(1...9)
        
        Section("Promo Setting") {
            PickerButtonCell(label: "Promo Duration", val: $promoDur,options: promoDurOptions)
            PickerButtonCell(label: "Rest Duration", val: $restDur,options: restDurOptions)
            PickerButtonCell(label: "Long Rest Duration", val: $longRestDur,options: longRestDurOptions)
            
            Picker("Interval", selection: $longRestInterval) {
                ForEach(longRestIntervalOptions, id: \.self) {
                    Text("\($0)").tag($0)
                }
            }
            .pickerStyle(.menu)
            
            ToggleButtonCell(label: "Vibrable", val: $isVibrable)
            ToggleButtonCell(label: "Ticking", val: $ticking)
            ToggleButtonCell(label: "Remind Sound when ending", val: $endingReminder)
        }
    }
    
    @ViewBuilder
    func LogoutSection() -> some View {
        Section {
            Button(action: {
                print("Log out")
            }, label: {
                Text("Log Out")
            })
        }
    }
}

#Preview {
    SettingView()
}

struct ToggleButtonCell: View {
    var label: String
    @Binding var val: Bool
    
    var body: some View {
        HStack {
            Toggle(label, isOn: $val)
        }
    }
}

struct PickerButtonCell<Option:SettingEnum>: View {
    var label: String
    @Binding var val: Option
    var options: [Option]
    
    var body: some View {
        HStack {
            Picker(label, selection: $val) {
                ForEach(options) {
                    Text($0.displayValue).tag($0)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

enum TimeDur: String, CaseIterable,SettingEnum {
    var displayValue: String { self.rawValue }
    var id: String { self.rawValue }
    
    case min5  = "5 mins"
    case min10 = "10 mins"
    case min15 = "15 mins"
    case min20 = "20 mins"
    case min25 = "25 mins"
    case min30 = "30 mins"
    case min35 = "35 mins"
    case min40 = "40 mins"
    case min45 = "45 mins"
    case min50 = "50 mins"
    case min55 = "55 mins"
    case min60 = "60 mins"
}
    

enum FontSize: String, CaseIterable,SettingEnum {
    var displayValue: String { self.rawValue}
    var id: String { self.rawValue }
    
    case sizeS = "S"
    case sizeM = "M"
    case sizeL = "L"
    case sizeXL = "XL"
}
    

enum BackgroundSkin: String, CaseIterable, SettingEnum {
    var displayValue: String { self.rawValue }
    var id: String { self.rawValue }
    
    case system = "System"
    case light = "light"
    case dark = " dark"
}
    
protocol SettingEnum: Identifiable, Hashable {
    var displayValue: String { get }
}
