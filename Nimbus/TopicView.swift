//
//  TopicView.swift
//  Nimbus
//
//  Created by Mohameth Seck on 1/9/25.
//

import SwiftUI

// TopicView displays the details of a single component/topic
// It shows:
// 1. Live preview of the component
// 2. Source code
// 3. List of modifiers used
// 4. Documentation links
// 5. GitHub link
struct TopicView: View {
    // The topic to display
    let topic: Topic
    // Add environment object for favorites
    @EnvironmentObject var favoriteManager: FavoriteManager
    @EnvironmentObject private var recentlyViewedManager: RecentlyViewedManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Add favorite button in the navigation bar
                HStack {
                    Spacer()
                    Button(action: {
                        favoriteManager.toggleFavorite(for: topic.name)
                    }) {
                        Image(systemName: favoriteManager.isFavorite(topic.name) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                
                // Preview Section
                previewSection
                
                // Source Code Section
                sourceCodeSection
                
                // Modifiers Section
                modifiersSection
                
                // Documentation Links
                documentationSection
                
                // GitHub Link
                githubSection
            }
            .padding()
        }
        .navigationTitle(topic.name)
        .onAppear {
            recentlyViewedManager.addTopic(topic.name)
        }
    }
    
    // MARK: - Preview Section
    private var previewSection: some View {
        VStack {
            Text("Preview")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Group {
                switch topic.name {
                case "Circle Pulse":
                    CirclePulseView()
                case "Wave Animation":
                    WaveView()
                case "Interactive Carousel":
                    CarouselView()
                default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
        }
    }
    
    // MARK: - Source Code Section
    private var sourceCodeSection: some View {
        VStack(alignment: .leading) {
            Text("Source Code")
                .font(.title2)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                Text(topic.sourceCode)
                    .font(.system(.body, design: .monospaced))
                    .padding()
            }
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
    
    // MARK: - Modifiers Section
    private var modifiersSection: some View {
        VStack(alignment: .leading) {
            Text("Modifiers Used")
                .font(.title2)
                .bold()
            
            ForEach(topic.modifiers, id: \.self) { modifier in
                Text("• " + modifier)
                    .font(.body)
            }
        }
    }
    
    // MARK: - Documentation Section
    @ViewBuilder
    private var documentationSection: some View {
        if let links = topic.documentationLinks {
            VStack(alignment: .leading) {
                Text("Documentation")
                    .font(.title2)
                    .bold()
                
                ForEach(links, id: \.self) { link in
                    Link(destination: URL(string: link)!) {
                        Text(link)
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
    
    // MARK: - GitHub Section
    @ViewBuilder
    private var githubSection: some View {
        if let githubURL = topic.githubURL {
            Link(destination: URL(string: githubURL)!) {
                HStack {
                    Image(systemName: "link")
                    Text("View on GitHub")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TopicView(topic: Topic(name: "Circle Pulse", details: "A pulse animation with a circle shape", category: "Animations", modifiers: ["animation"]))
            .environmentObject(FavoriteManager())
            .environmentObject(RecentlyViewedManager())
    }
}
