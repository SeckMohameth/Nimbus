//
//  OnboardingView.swift
//  Nimbus
//
//  Created by Mohameth Seck on 1/9/25.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var isAnimating = false
    
    var body: some View {
        TabView {
            // First page with github background
            OnboardingPage(
                title: "Welcome to Nimbus",
                description: "Your SwiftUI Component Library",  // Shorter description
                imageName: "square.grid.2x2",
                backgroundImage: "github"
            )
            
            // Second page with xcode background
            OnboardingPage(
                title: "Browse Components",
                description: "Find and learn SwiftUI examples",  // Shorter description
                imageName: "doc.text.magnifyingglass",
                backgroundImage: "xcode"
            )
            
            // Third page with cafe background
            OnboardingPage(
                title: "Save Favorites",
                description: "Bookmark components for quick access",  // Shorter description
                imageName: "star.fill",
                backgroundImage: "cafe"
            )
            
            // Final page with logo
            ZStack {
                Image("github")
                    .resizable()
                    .scaledToFill()
                    .overlay(Color.black.opacity(0.4))
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .scaleEffect(isAnimating ? 1.0 : 0.5)
                        .opacity(isAnimating ? 1.0 : 0.0)
                        .animation(.easeOut(duration: 0.8), value: isAnimating)
                    
                    Text("Ready to Start?")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .opacity(isAnimating ? 1.0 : 0.0)
                        .offset(y: isAnimating ? 0 : 20)
                        .animation(.easeOut(duration: 0.8).delay(0.3), value: isAnimating)
                    
                    Button("Get Started") {
                        withAnimation {
                            hasCompletedOnboarding = true
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    .opacity(isAnimating ? 1.0 : 0.0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.5), value: isAnimating)
                }
                .padding(.horizontal, 20)
            }
            .onAppear { isAnimating = true }
            .onDisappear { isAnimating = false }
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
    }
}

struct OnboardingPage: View {
    let title: String
    let description: String
    let imageName: String
    let backgroundImage: String
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Background Image
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.5))
                .ignoresSafeArea()
            
            // Content
            VStack(spacing: 40) {
                Spacer()
                
                Image(systemName: imageName)
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .opacity(isAnimating ? 1.0 : 0.0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.easeOut(duration: 0.8), value: isAnimating)
                
                VStack(spacing: 25) {  // Increased spacing between title and description
                    Text(title)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                    
                    Text(description)
                        .font(.system(size: 22))  // Slightly larger font
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal, 32)  // Increased horizontal padding
                .opacity(isAnimating ? 1.0 : 0.0)
                .offset(y: isAnimating ? 0 : 20)
                .animation(.easeOut(duration: 0.8).delay(0.2), value: isAnimating)
                
                Spacer()
                Spacer()
            }
            .padding(.bottom, 60)
        }
        .onAppear { isAnimating = true }
        .onDisappear { isAnimating = false }
    }
}

#Preview {
    OnboardingView()
}
