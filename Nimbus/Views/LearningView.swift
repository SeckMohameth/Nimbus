
import SwiftUI
import SwiftData

struct LearningView: View {
    @Query(sort: \LearningTopic.order) private var topics: [LearningTopic]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Dictionary(grouping: topics, by: { $0.category })
                    .sorted(by: { $0.key < $1.key }), id: \.key) { category, topics in
                    Section(header: Text(category)) {
                        ForEach(topics) { topic in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(topic.name)
                                        .font(.headline)
                                    Text(topic.details)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: topic.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(topic.isCompleted ? .green : .gray)
                                    .onTapGesture {
                                        topic.isCompleted.toggle()
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Learning Path")
        }
    }
}
