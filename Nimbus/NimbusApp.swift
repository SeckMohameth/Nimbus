import SwiftUI
import SwiftData

@main
struct NimbusApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: LearningTopic.self)
            addInitialTopicsIfNeeded()
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                ContentView()
                    .environmentObject(RecentlyViewedManager())
            } else {
                OnboardingView()
            }
        }
        .modelContainer(modelContainer)
    }
    
    private func addInitialTopicsIfNeeded() {
        Task { @MainActor in
            let context = modelContainer.mainContext
            let fetchDescriptor = FetchDescriptor<LearningTopic>()
            
            guard try! context.fetch(fetchDescriptor).isEmpty else { return }
            
            let topics: [(String, String, String, String, Int)] = [
                // Swift Basics
                ("Variables & Constants", "Swift Basics", "Learn about var and let declarations",
                 "Variables (var) are mutable and can be changed, while constants (let) are immutable. Swift encourages using constants by default to make code safer and more predictable.\n\nKey concepts:\n• Type inference\n• Type safety\n• Mutability vs Immutability\n• Naming conventions", 0),
                
                ("Data Types", "Swift Basics", "Understanding Swift's basic data types",
                 "Swift has several basic data types:\n• String: Text data\n• Int: Whole numbers\n• Double: Decimal numbers\n• Bool: True/false values\n• Array: Ordered collections\n• Dictionary: Key-value pairs\n\nLearn how to use them effectively and when to choose each type.", 1),
                
                ("Control Flow", "Swift Basics", "If statements, switches, and loops",
                 "Control flow determines the order in which code executes:\n• If/else statements for conditional logic\n• Switch statements for pattern matching\n• For-in loops for iteration\n• While loops for conditional iteration\n• Guard statements for early exits", 2),
                
                // SwiftUI Fundamentals
                ("Views", "SwiftUI Fundamentals", "Understanding View protocol and basic views",
                 "Views are the building blocks of SwiftUI interfaces:\n• Text for displaying strings\n• Image for showing images\n• Button for user interaction\n• TextField for user input\n• Stack views for layout\n\nLearn how to compose these views to create complex interfaces.", 3),
                
                ("State & Binding", "SwiftUI Fundamentals", "@State and @Binding properties",
                 "State management is crucial in SwiftUI:\n• @State for simple view-local state\n• @Binding for sharing state between views\n• When to use each property wrapper\n• How state updates trigger view updates\n• Best practices for state management", 4),
                
                ("Layout & Navigation", "SwiftUI Fundamentals", "Working with stacks and navigation",
                 "Learn how to structure your app's interface:\n• VStack, HStack, and ZStack\n• NavigationStack for navigation\n• Lists and ScrollViews\n• Flexible layouts with GeometryReader\n• Custom alignment and spacing", 5),
                
                // Data Flow
                ("ObservableObject", "Data Flow", "Understanding the Observable protocol",
                 "Learn about SwiftUI's data flow:\n• Creating observable classes\n• @Published properties\n• @StateObject vs @ObservedObject\n• When to use each approach\n• Best practices for data management", 6),
                
                ("Environment", "Data Flow", "Using EnvironmentObject and Environment",
                 "Share data throughout your app:\n• EnvironmentObject for sharing objects\n• Environment values for system settings\n• Custom environment keys\n• Dependency injection patterns", 7),
                
                // Advanced Topics
                ("Animations", "Advanced Topics", "SwiftUI animation system",
                 "Create fluid user interfaces:\n• Basic animations\n• Spring animations\n• Transitions\n• Custom animations\n• Animation timing curves", 8),
                
                ("Gestures", "Advanced Topics", "Handling user interactions",
                 "Implement touch interactions:\n• Tap gestures\n• Long press gestures\n• Drag gestures\n• Rotation and magnification\n• Custom gesture recognizers", 9)
            ]
            
            for (name, category, details, content, order) in topics {
                let topic = LearningTopic(name: name, category: category, details: details, content: content, order: order)
                context.insert(topic)
            }
        }
    }

    // Manager class for recently viewed topics
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
}
