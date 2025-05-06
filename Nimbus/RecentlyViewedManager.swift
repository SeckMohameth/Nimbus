
import SwiftUI

class RecentlyViewedManager: ObservableObject {
    @Published private(set) var recentTopics: [String] = []
    private let maxItems = 5
    
    init() {
        // Load saved topics from UserDefaults
        if let data = UserDefaults.standard.data(forKey: "recentlyViewed"),
           let topics = try? JSONDecoder().decode([String].self, from: data) {
            recentTopics = topics
        }
    }
    
    func addTopic(_ topicName: String) {
        var updated = recentTopics
        // Remove if already exists
        updated.removeAll { $0 == topicName }
        // Add to beginning
        updated.insert(topicName, at: 0)
        // Keep only last 5
        recentTopics = Array(updated.prefix(maxItems))
        // Save to UserDefaults
        if let data = try? JSONEncoder().encode(recentTopics) {
            UserDefaults.standard.set(data, forKey: "recentlyViewed")
        }
    }
}
