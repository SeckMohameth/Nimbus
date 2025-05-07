//
//  TopicData.swift
//  Nimbus
//
//  Created by Mohameth Seck on 1/9/25.
//

import Foundation

// TopicData is a static data store that holds all the component examples in our library
class TopicData {
    // Static property means we can access this without creating an instance of TopicData
    // This array contains all our component examples
    static let topics: [Topic] = [
        // Circle Pulse Animation
        Topic(
            name: "Circle Pulse",
            details: "A pulsing circle animation that can be used for loading states or visual feedback",
            category: "Animations",
            modifiers: ["animation", "scaleEffect", "opacity"],
            sourceCode: """
            struct CirclePulseView: View {
                @State private var isAnimating = false
                
                var body: some View {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 50, height: 50)
                        .scaleEffect(isAnimating ? 1.5 : 1.0)
                        .opacity(isAnimating ? 0.5 : 1.0)
                        .animation(.easeInOut(duration: 1.0).repeatForever(), value: isAnimating)
                        .onAppear {
                            isAnimating = true
                        }
                }
            }
            """,
            documentationLinks: [
                "https://developer.apple.com/documentation/swiftui/animation",
                "https://developer.apple.com/documentation/swiftui/view/scaleeffect(_:)"
            ],
            githubURL: "https://github.com/SeckMohameth/Nimbus/blob/main/Animations/CirclePulseView.swift"
        ),
        
        // Wave Animation
        Topic(
            name: "Wave Animation",
            details: "A smooth wave animation effect using SwiftUI paths",
            category: "Animations",
            modifiers: ["TimelineView", "Canvas", "Path"],
            sourceCode: """
            struct WaveView: View {
                @State private var phase = 0.0
                
                var body: some View {
                    TimelineView(.animation) { timeline in
                        Canvas { context, size in
                            let width = size.width
                            let height = size.height
                            let midHeight = height * 0.5
                            
                            context.translateBy(x: 0, y: midHeight)
                            
                            var path = Path()
                            path.move(to: CGPoint(x: 0, y: 0))
                            
                            for x in stride(from: 0, through: width, by: 1) {
                                let relativeX = x / 50
                                let sine = sin(relativeX + phase)
                                let y = sine * 20
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                            
                            context.stroke(path, with: .color(.blue), lineWidth: 3)
                        }
                        .onChange(of: timeline.date) { _, _ in
                            phase += 0.05
                        }
                    }
                    .frame(height: 100)
                }
            }
            """,
            documentationLinks: [
                "https://developer.apple.com/documentation/swiftui/timelineview",
                "https://developer.apple.com/documentation/swiftui/canvas"
            ],
            githubURL: "https://github.com/SeckMohameth/Nimbus/blob/main/Animations/WaveView.swift"
        ),
        
        Topic(
            name: "Interactive Wave Animation",
            details: "A smooth wave animation effect with adjustable speed using SwiftUI paths and sliders",
            category: "Animations",
            modifiers: ["TimelineView", "Canvas", "Path", "Slider", "Binding"],
            sourceCode: """
            struct WaveView: View {
                @State private var phase = 0.0
                @State private var speed = 0.05
                
                var body: some View {
                    VStack {
                        TimelineView(.animation) { timeline in
                            Canvas { context, size in
                                let width = size.width
                                let height = size.height
                                let midHeight = height * 0.5
                                
                                context.translateBy(x: 0, y: midHeight)
                                
                                var path = Path()
                                path.move(to: CGPoint(x: 0, y: 0))
                                
                                for x in stride(from: 0, through: width, by: 1) {
                                    let relativeX = x / 50
                                    let sine = sin(relativeX + phase)
                                    let y = sine * 20
                                    path.addLine(to: CGPoint(x: x, y: y))
                                }
                                
                                context.stroke(path, with: .color(.blue), lineWidth: 3)
                            }
                            .onChange(of: timeline.date) { _, _ in
                                phase += speed
                            }
                        }
                        .frame(height: 100)
                        
                        SpeedControlView(speed: $speed)
                    }
                }
            }
            """,
            documentationLinks: [
                "https://developer.apple.com/documentation/swiftui/timelineview",
                "https://developer.apple.com/documentation/swiftui/canvas",
                "https://developer.apple.com/documentation/swiftui/slider"
            ],
            githubURL: "https://github.com/SeckMohameth/Nimbus/blob/main/Animations/WaveView.swift"
        ),
        
        Topic(
            name: "Interactive Circle Pulse",
            details: "A customizable pulsing circle animation with color selection and size control",
            category: "Animations",
            modifiers: ["animation", "scaleEffect", "opacity", "Slider", "ScrollView"],
            sourceCode: """
            struct CirclePulseView: View {
                @State private var isAnimating = false
                @State private var selectedColor: Color = .blue
                @State private var pulseSize: CGFloat = 1.5
                
                let colors: [Color] = [.blue, .red, .green, .purple, .orange]
                
                var body: some View {
                    VStack {
                        Circle()
                            .fill(selectedColor)
                            .frame(width: 50, height: 50)
                            .scaleEffect(isAnimating ? pulseSize : 1.0)
                            .opacity(isAnimating ? 0.5 : 1.0)
                            .animation(.easeInOut(duration: 1.0).repeatForever(), value: isAnimating)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(colors, id: \\.self) { color in
                                    Circle()
                                        .fill(color)
                                        .frame(width: 30, height: 30)
                                        .overlay(
                                            Circle()
                                                .stroke(selectedColor == color ? Color.white : Color.clear, lineWidth: 2)
                                        )
                                        .onTapGesture {
                                            selectedColor = color
                                        }
                                }
                            }
                            .padding()
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Pulse Size")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Slider(value: $pulseSize, in: 1.2...2.0)
                                .accentColor(selectedColor)
                        }
                        .padding()
                    }
                }
            }
            """,
            documentationLinks: [
                "https://developer.apple.com/documentation/swiftui/animation",
                "https://developer.apple.com/documentation/swiftui/view/scaleeffect(_:)",
                "https://developer.apple.com/documentation/swiftui/slider"
            ],
            githubURL: "https://github.com/SeckMohameth/Nimbus/blob/main/Animations/CirclePulseView.swift"
        ),
        
        Topic(
            name: "Interactive Carousel",
            details: "A swipeable carousel with spring animations, interactive dots, and smooth transitions",
            category: "Navigation",
            modifiers: ["GeometryReader", "DragGesture", "spring animation", "scaleEffect"],
            sourceCode: """
            struct CarouselView: View {
                @State private var currentIndex = 0
                @State private var dragOffset: CGFloat = 0
                @State private var springAnimation = true
                
                private let items = ["🎯", "🎮", "📱", "💻", "⌚️"]
                
                var body: some View {
                    VStack {
                        GeometryReader { geometry in
                            HStack(spacing: 0) {
                                ForEach(items.indices, id: \\.self) { index in
                                    Text(items[index])
                                        .font(.system(size: 50))
                                        .frame(width: geometry.size.width)
                                        .offset(x: -CGFloat(currentIndex) * geometry.size.width)
                                        .offset(x: dragOffset)
                                        .animation(springAnimation ? .spring(response: 0.5, dampingFraction: 0.8) : .none, value: dragOffset)
                                }
                            }
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        springAnimation = false
                                        dragOffset = value.translation.width
                                    }
                                    .onEnded { value in
                                        springAnimation = true
                                        let threshold = geometry.size.width * 0.3
                                        withAnimation {
                                            if value.translation.width > threshold && currentIndex > 0 {
                                                currentIndex -= 1
                                            } else if value.translation.width < -threshold && currentIndex < items.count - 1 {
                                                currentIndex += 1
                                            }
                                            dragOffset = 0
                                        }
                                    }
                            )
                        }
                        .frame(height: 100)
                        
                        HStack(spacing: 10) {
                            ForEach(items.indices, id: \\.self) { index in
                                Circle()
                                    .fill(currentIndex == index ? Color.blue : Color.gray.opacity(0.5))
                                    .frame(width: 8, height: 8)
                                    .scaleEffect(currentIndex == index ? 1.2 : 1.0)
                                    .animation(.spring(response: 0.3), value: currentIndex)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                            currentIndex = index
                                        }
                                    }
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            """,
            documentationLinks: [
                "https://developer.apple.com/documentation/swiftui/geometryreader",
                "https://developer.apple.com/documentation/swiftui/gesture",
                "https://developer.apple.com/documentation/swiftui/animation"
            ],
            githubURL: "https://github.com/SeckMohameth/Nimbus/blob/main/Animations/CarouselView.swift"
        )
    ]
}
