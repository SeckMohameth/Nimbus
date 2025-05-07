import SwiftUI

struct CarouselView: View {
    @State private var currentIndex = 0
    @State private var dragOffset: CGFloat = 0
    @State private var springAnimation = true
    
    private let items = ["🎯", "🎮", "📱", "💻", "⌚️"]
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
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
            
            // Enhanced dots indicator
            HStack(spacing: 10) {
                ForEach(items.indices, id: \.self) { index in
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

#Preview {
    CarouselView()
}
