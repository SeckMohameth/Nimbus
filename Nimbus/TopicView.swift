//
//  TopicView.swift
//  Nimbus
//
//  Created by Mohameth Seck on 1/9/25.
//

import SwiftUI

struct TopicView: View {
    var topic: Topic
    
    var body: some View {
        Text(topic.name)
    }
}

#Preview {
    NavigationStack {
        TopicView(topic: Topic(name: "Circle Pulse", details: "A pulse animation with a circle shape", category: "Animations", modifiers: ["animation"]))
        }
}
