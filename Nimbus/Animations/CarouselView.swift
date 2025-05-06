
import SwiftUI

struct CarouselView: View {
    @State private var currentIndex = 0
    private let items = ["🎯", "🎮", "📱", "💻", "⌚️"]
    @State private var offset: CGFloat = 0
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
                        Text(items[index])
                            .font(.system(size: 50))
                            .frame(width: geometry.size.width)
                            .offset(x: -CGFloat(currentIndex) * geometry.size.width + offset)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation.width
                        }
                        .onEnded { value in
                            let threshold = geometry.size.width * 0.3
                            withAnimation {
                                if value.translation.width > threshold && currentIndex > 0 {
                                    currentIndex -= 1
                                } else if value.translation.width < -threshold && currentIndex < items.count - 1 {
                                    currentIndex += 1
                                }
                                offset = 0
                            }
                        }
                )
            }
            .frame(height: 100)
            
            // Dots indicator
            HStack(spacing: 10) {
                ForEach(items.indices, id: \.self) { index in
                    Circle()
                        .fill(currentIndex == index ? Color.blue : Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    CarouselView()
}
