//
//  Topic.swift
//  Nimbus
//
//  Created by Mohameth Seck on 1/9/25.
//

import Foundation

class Topic {
    var name: String
    var details: String
    var category: String
    var modifiers: [String]
    
    init(name: String, details: String, category: String, modifiers: [String]) {
        self.name = name
        self.details = details
        self.category = category
        self.modifiers = modifiers
    }
}
