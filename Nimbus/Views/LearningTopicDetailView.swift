
import SwiftUI

struct LearningTopicDetailView: View {
    let topic: LearningTopic
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Category label
                Text(topic.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                // Topic details
                VStack(alignment: .leading, spacing: 15) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    Text(topic.details)
                        .foregroundColor(.secondary)
                    
                    if let content = topic.content {
                        Text("What you'll learn")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                        
                        Text(content)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Completion status
                HStack {
                    Text("Mark as completed")
                    Spacer()
                    Image(systemName: topic.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(topic.isCompleted ? .green : .gray)
                        .imageScale(.large)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                .onTapGesture {
                    topic.isCompleted.toggle()
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(topic.name)
        .background(Color(.systemGroupedBackground))
    }
}
