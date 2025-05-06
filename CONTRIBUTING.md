# 🤝 Contributing to Nimbus

Thank you for your interest in contributing to Nimbus! This app is built to grow with community input, and every contribution — big or small — is appreciated.

---

## ✨ What You Can Contribute

- New SwiftUI views ("Topics")  
- Better explanations or code examples  
- Bug fixes or UI improvements  
- Accessibility enhancements  
- Documentation updates

---

## 🧱 How to Add a New Topic

When adding a new SwiftUI component to the app, please include:

1. **A SwiftUI view** in its own file or within the appropriate category.
2. **A `Topic` model** instance with the following fields:

```swift
Topic(
    name: "My Custom Card View",
    description: "A reusable card layout with rounded corners and shadow.",
    category: .layout,
    iOSVersion: "16.0",
    modifiersUsed: ["padding()", "background()", "cornerRadius()", "shadow()"],
    sourceCode: """
    struct MyCustomCardView: View {
        var body: some View {
            VStack {
                Text("Hello, Nimbus!")
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
        }
    }
    """,
    documentationLinks: ["https://developer.apple.com/documentation/swiftui/view"],
    githubURL: "https://github.com/your-username/your-repo"
)
