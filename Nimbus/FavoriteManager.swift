import Foundation

// FavoriteManager handles the state and storage of favorite topics
class FavoriteManager: ObservableObject {
    // Published property to notify views when favorites change
    @Published private(set) var favoriteTopics: Set<String> = []
    
    // Key for storing favorites in UserDefaults
    private let favoritesKey = "favoriteTopics"
    
    init() {
        // Load favorites from UserDefaults when initialized
        if let savedFavorites = UserDefaults.standard.array(forKey: favoritesKey) as? [String] {
            favoriteTopics = Set(savedFavorites)
        }
    }
    
    // Toggle favorite status for a topic
    func toggleFavorite(for topicName: String) {
        if favoriteTopics.contains(topicName) {
            favoriteTopics.remove(topicName)
        } else {
            favoriteTopics.insert(topicName)
        }
        // Save to UserDefaults
        UserDefaults.standard.set(Array(favoriteTopics), forKey: favoritesKey)
    }
    
    // Check if a topic is favorited
    func isFavorite(_ topicName: String) -> Bool {
        favoriteTopics.contains(topicName)
    }
}

// End of file. No additional code.
