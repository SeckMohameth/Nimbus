import SwiftUI

struct OnboardingItem {
    let title: String
    let description: String
    let systemImage: String
}

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var isOnboardingComplete = false
    @State private var imageScale = 0.8
    @State private var textOpacity = 0.0
    
    let items = [
        OnboardingItem(
            title: "SwiftUI Components Library",
            description: "Discover a curated collection of beautiful and reusable SwiftUI components",
            systemImage: "square.grid.2x2"
        ),
        OnboardingItem(
            title: "Learn & Implement",
            description: "Each component comes with detailed code examples and documentation",
            systemImage: "doc.text.magnifyingglass"
        ),
        OnboardingItem(
            title: "Contribute & Share",
            description: "Join our community and share your own SwiftUI components",
            systemImage: "person.2.fill"
        )
    ]
    
    var body: some View {
        if isOnboardingComplete {
            ContentView()
        } else {
            TabView(selection: $currentPage) {
                ForEach(0..<items.count, id: \.self) { index in
                    VStack(spacing: 30) {
                        if index == 0 {
                            // App logo
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .scaleEffect(imageScale)
                        } else {
                            // System icon
                            Image(systemName: items[index].systemImage)
                                .font(.system(size: 60))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .pink],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .scaleEffect(imageScale)
                        }
                        
                        Text(items[index].title)
                            .font(.title2)
                            .bold()
                            .opacity(textOpacity)
                        
                        Text(items[index].description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 32)
                            .opacity(textOpacity)
                        
                        if index == items.count - 1 {
                            Button(action: {
                                withAnimation {
                                    isOnboardingComplete = true
                                }
                            }) {
                                Text("Get Started")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 200, height: 50)
                                    .background(
                                        LinearGradient(
                                            colors: [.blue, .pink],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(25)
                            }
                            .opacity(textOpacity)
                        }
                    }
                    .tag(index)
                    .onAppear {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            imageScale = 1.0
                        }
                        withAnimation(.easeIn(duration: 0.4).delay(0.2)) {
                            textOpacity = 1.0
                        }
                    }
                    .onDisappear {
                        imageScale = 0.8
                        textOpacity = 0.0
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .background(
                LinearGradient(
                    colors: [.white, Color(.systemGray6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
}

#Preview {
    OnboardingView()
}

// End of file. No additional code.
