//
//  LoginScreenView.swift
//  Pomotron
//
//  Created by Ge Ding on 2/13/24.
//

import SwiftUI

struct LoginScreenView: View {
    var body: some View {
        ZStack {
            GeometryReader { _ in
                
                Image("Pic3")
                    .resizable()
                    .scaledToFill()
     
                LinearGradient(colors: [
                    .clear,
                    .black.opacity(0.5),
                    .black
                ], startPoint: .top, endPoint: .bottom)
            }
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                SignInButton(image: Image("google-logo"), text: "Sign in with Google") {
                    
                }
                
                SignInButton(image: Image("facebook-logo"), text: "Sign in with Facebook") {
                    
                }
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    LoginScreenView()
}

struct SignInButton: View {
    var image: Image
    var text: String
    var onClick: ()->()
    
    var body: some View {
        HStack {
            image
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
            
            Text(text)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .foregroundColor(.white)
        .padding(.vertical, 15)
        .padding(.horizontal, 40)
        .background(.white.opacity(0.1), in: Capsule())
        .onTapGesture{onClick()}
    }
}

/// Mark: Authentication Function
extension LoginScreenView {
    
}

