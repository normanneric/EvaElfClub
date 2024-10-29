//
//  TabView.swift
//  EvaClub
//
//  Created by D K on 24.10.2024.
//

import SwiftUI

struct TabMainView: View {
    
    @State private var current = "Main"
    @State private var isTabBarShown = true
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var isOnboardingShown = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $current) {
                    ClubNewsView()
                        .tag("News")
                    
                    MainView()
                        .tag("Main")
                    
                    ProfileView()
                        .environmentObject(authViewModel)
                        .tag("Profile")
                }
                
                if isTabBarShown {
                    
                    HStack(spacing: 0) {
                        Spacer(minLength: 0)
                        
                        TabButton(title: "News", image: "iconNews", selected: $current)
                        
                        Spacer(minLength: 0)
                        
                        TabButton(title: "Main", image: "iconSearch", selected: $current)

                        Spacer(minLength: 0)
                        
                        TabButton(title: "Profile", image: "iconUser", selected: $current)
                        
                        Spacer(minLength: 0)
                    }
                    .frame(width: size().width - 55, height: 80)
                    .padding(.vertical)
                    .padding(.horizontal)
                    .background {
                        Rectangle()
                            .foregroundColor(.darkGray)
                            .frame(width: size().width - 60, height: 90)
                            .cornerRadius(40)
                    }
                    .padding(.horizontal, 25)
                }
            }
        }
        .onAppear {
            DataManager.shared.createInitialData()
            isOnboardingShown = UserDefaults.standard.bool(forKey: "onboarding")
        }
        .fullScreenCover(isPresented: $isOnboardingShown) {
            WelcomeView() {
                UserDefaults.standard.setValue(false, forKey: "onboarding")            
                isOnboardingShown.toggle()
            }
        }
    }
}

#Preview {
    TabMainView()
        .environmentObject(AuthViewModel())
}

struct TabButton: View {
    var title: String
    var image: String
    
    @Binding var selected: String
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                selected = title
            }
        } label: {
            HStack(spacing: 10) {
                Image(image)
                    .resizable()
                    .colorInvert()
                    .scaledToFill()
                    .frame(width: 40, height: 40)

            }
            .foregroundColor(.white)
            .padding(.vertical, 7)
            .padding(.horizontal)
            .background(
                Rectangle()
                    .fill(Color.white.opacity(selected == title ? 0.08 : 0))
                    .cornerRadius(18)
            )
        }
    }
}
