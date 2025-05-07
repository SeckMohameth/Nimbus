import SwiftUI
import SwiftData

struct LearningView: View {
    @Query(sort: \LearningTopic.order) private var topics: [LearningTopic]
    @Environment(\.modelContext) private var modelContext
    
    private var completionPercentage: Double {
        guard !topics.isEmpty else { return 0 }
        let completedCount = topics.filter { $0.isCompleted }.count
        return Double(completedCount) / Double(topics.count)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your Learning Journey")
                            .font(.headline)
                        
                        Text("Track your progress through Swift and SwiftUI fundamentals. Complete topics by tapping the circles, and dive deeper into each topic for detailed explanations.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading) {
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .frame(width: geometry.size.width, height: 8)
                                        .opacity(0.1)
                                        .foregroundColor(.blue)
                                    
                                    Rectangle()
                                        .frame(width: geometry.size.width * completionPercentage, height: 8)
                                        .foregroundColor(.blue)
                                }
                                .cornerRadius(4)
                            }
                            .frame(height: 8)
                            
                            Text("\(Int(completionPercentage * 100))% Complete")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 5)
                    }
                    .padding(.vertical, 8)
                }
                
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
