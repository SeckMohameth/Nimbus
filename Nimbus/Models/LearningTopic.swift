
import Foundation
import SwiftData

@Model
final class LearningTopic {
    var name: String
    var category: String
    var details: String
    var isCompleted: Bool
    var order: Int
    
    init(name: String, category: String, details: String, order: Int, isCompleted: Bool = false) {
        self.name = name
        self.category = category
        self.details = details
        self.order = order
        self.isCompleted = isCompleted
    }
}
