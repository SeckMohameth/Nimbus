//
//  CirclePulseView.swift
//  Nimbus
//
//  Created by Mohameth Seck on 1/9/25.
//

import SwiftUI

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
            
            // Color picker
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(colors, id: \.self) { color in
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
            
            // Pulse size control
            VStack(alignment: .leading) {
                Text("Pulse Size")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Slider(value: $pulseSize, in: 1.2...2.0)
                    .accentColor(selectedColor)
            }
            .padding()
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    CirclePulseView()
}
