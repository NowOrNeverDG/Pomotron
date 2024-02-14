//
//  OnboardingView.swift
//  Pomotron
//
//  Created by Ge Ding on 2/6/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var pageIndex = 0
    private let pages: [Page] = Page.pages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                VStack {
                    Spacer()
                    PageView(page)
                    Spacer()
                    
                    if page == pages.last {
                        Button("Sign up", action: goToZero)
                            .buttonStyle(.bordered)
                    } else {
                        Button("Next",action: incrementPage)
                    }
                    Spacer()
                }
                .tag(page.tag)
            }
        }
        .animation(.easeInOut, value: pageIndex)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .onAppear{
            dotAppearance.currentPageIndicatorTintColor = .black
            dotAppearance.pageIndicatorTintColor = .gray
        }
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
    
    
    @ViewBuilder
    func PageView(_ page: Page) -> some View {
        VStack(spacing: 20) {
            Image("\(page.imageUrl)")
                .resizable()
                .scaledToFit()
                .padding()
                .cornerRadius(30)
            
            Text(page.name)
                .font(.title)
            
            Text(page.description)
                .font(.subheadline)
                .frame(width: 300)
        }
    }
}

#Preview {
    OnboardingView()
}

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var pages:[Page] = [
    Page(name: "Welcome to Promotron", description: "The  app to get stuff done in an app", imageUrl: "cowork", tag: 0),
    Page(name: "Meet New people", description: "The perfect place to track what your focus on", imageUrl: "work", tag: 1),
    Page(name: "To do", description: "recording your to do", imageUrl: "website", tag: 2)
    ]
}
