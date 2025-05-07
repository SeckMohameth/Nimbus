//
//  ContentView.swift
//  Nimbus
//
//  Created by Mohameth Seck on 1/9/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var favoriteManager = FavoriteManager()
    @StateObject private var recentlyViewedManager = RecentlyViewedManager()
    
    var body: some View {
        TabView {
            // MARK: - Components List Tab
            NavigationStack {
                List {
                    // Recently viewed section
                    RecentlyViewedView(topics: TopicData.topics)
                    
                    // Group topics by category and sort them alphabetically
                    ForEach(Dictionary(grouping: TopicData.topics, by: { $0.category })
                        .sorted(by: { $0.key < $1.key }), id: \.key) { category, topics in
                        Section(header: Text(category)) {
                            ForEach(topics) { topic in
                                NavigationLink(destination: TopicView(topic: topic)) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(topic.name)
                                                .font(.headline)
                                            Text(topic.details)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        Image(systemName: favoriteManager.isFavorite(topic.name) ? "star.fill" : "star")
                                            .foregroundColor(.yellow)
                                            .onTapGesture {
                                                favoriteManager.toggleFavorite(for: topic.name)
                                            }
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("SwiftUI Components")
            }
            .tabItem {
                Label("Components", systemImage: "square.grid.2x2")
            }
            
            // MARK: - Learning Path Tab
            LearningView()
                .tabItem {
                    Label("Learn", systemImage: "book.fill")
                }
            
            // MARK: - Favorites Tab
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            
            // MARK: - Contribute Tab
            ContributeView()
                .tabItem {
                    Label("Contribute", systemImage: "heart.fill")
                }
        }
        .environmentObject(favoriteManager)
        .environmentObject(recentlyViewedManager)
    }
}

#Preview {
    ContentView()
        .environmentObject(FavoriteManager())
        .environmentObject(RecentlyViewedManager())
}
