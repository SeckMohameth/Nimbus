import Foundation
import SwiftData

@Model
final class LearningTopic {
    var name: String
    var category: String
    var details: String
    var content: String?
    var isCompleted: Bool
    var order: Int
    
    init(name: String, category: String, details: String, content: String? = nil, order: Int, isCompleted: Bool = false) {
        self.name = name
        self.category = category
        self.details = details
        self.content = content
        self.order = order
        self.isCompleted = isCompleted
    }
}
