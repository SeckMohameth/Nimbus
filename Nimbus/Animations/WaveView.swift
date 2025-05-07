import SwiftUI

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

#Preview {
    WaveView()
}
