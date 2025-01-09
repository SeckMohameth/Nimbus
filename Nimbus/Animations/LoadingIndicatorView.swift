//
//  LoadingIndicatorView.swift
//  Nimbus
//
//  Created by Mohameth Seck on 1/9/25.
//

import SwiftUI

struct CodeView: View {
    let sourceCode: String
    
    var body: some View {
        ScrollView {
            Text(sourceCode)
                .font(.system(.body, design: .monospaced))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct LoadingIndicatorView: View {
    @State private var isLoading: Bool = false
    @State private var showingCode: Bool = false
    
    let sourceCode = """
    \
    Circle()
        .trim(from: 0, to: 0.7)
        .stroke(Color.green, lineWidth: 6)
        .frame(width: 100, height: 100)
        .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
        .animation(.default.repeatForever(autoreverses: false), value: isLoading)
    """
    
    var body: some View {
        VStack {
            Spacer()
            
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.green, lineWidth: 6)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(.default.repeatForever(autoreverses: false), value: isLoading)
                .onAppear() {
                    isLoading = true
                }
            
            Spacer()
            
            Button(action: {
                showingCode.toggle()
            }) {
                Text(showingCode ? "Hide Code" : "Show Code")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if showingCode {
                CodeView(sourceCode: sourceCode)
                    .padding()
            }
        }
    }
}

#Preview {
    LoadingIndicatorView()
}
