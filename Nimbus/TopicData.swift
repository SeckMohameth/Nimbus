//
//  TopicData.swift
//  Nimbus
//
//  Created by Mohameth Seck on 1/9/25.
//

import Foundation

class TopicData: ObservableObject {
    @Published var topics: [Topic] = [
        Topic(name: "Circle Pulse", details: "a pulse animation with a circle shape", category: "Animations", modifiers: ["animation"]),
        Topic(name: "Spinning animation", details: "Making a spinning animation", category: "Animations", modifiers: ["animation", "rotation"])
    ]
}
