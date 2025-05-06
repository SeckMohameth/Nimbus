
import SwiftUI

struct SpeedControlView: View {
    @Binding var speed: Double
    let range: ClosedRange<Double>
    let label: String
    
    init(speed: Binding<Double>, range: ClosedRange<Double> = 0.01...0.2, label: String = "Animation Speed") {
        self._speed = speed
        self.range = range
        self.label = label
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "tortoise")
                    .foregroundColor(.secondary)
                
                Slider(value: $speed, in: range)
                    .accentColor(.blue)
                
                Image(systemName: "hare")
                    .foregroundColor(.secondary)
            }
            
            Text(String(format: "Speed: %.2f", speed))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
