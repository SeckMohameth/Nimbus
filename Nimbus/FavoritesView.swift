import SwiftUI

// View to display favorited components
struct FavoritesView: View {
    @EnvironmentObject var favoriteManager: FavoriteManager
    
    var body: some View {
        NavigationStack {
            List {
                // Filter topics to show only favorites
                ForEach(TopicData.topics.filter { favoriteManager.isFavorite($0.name) }) { topic in
                    NavigationLink(destination: TopicView(topic: topic)) {
                        VStack(alignment: .leading) {
                            Text(topic.name)
                                .font(.headline)
                            Text(topic.details)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            // Show a message when no favorites are added
            .overlay {
                if favoriteManager.favoriteTopics.isEmpty {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "star.fill",
                        description: Text("Add components to your favorites to see them here.")
                    )
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoriteManager())
}

// End of file. No additional code.
