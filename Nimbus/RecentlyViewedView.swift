import SwiftUI

struct RecentlyViewedView: View {
    @EnvironmentObject private var recentlyViewedManager: RecentlyViewedManager
    let topics: [Topic]
    
    var body: some View {
        if !recentlyViewedManager.recentTopics.isEmpty {
            Section(header: Text("Recently Viewed")) {
                ForEach(recentlyViewedManager.recentTopics, id: \.self) { topicName in
                    if let topic = topics.first(where: { $0.name == topicName }) {
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
            }
        }
    }
}

#Preview {
    RecentlyViewedView(topics: TopicData.topics)
        .environmentObject(RecentlyViewedManager())
}
