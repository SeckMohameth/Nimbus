//
//  Topic.swift
//  Nimbus
//
//  Created by Mohameth Seck on 1/9/25.
//

import Foundation

struct Topic: Identifiable {
    let id = UUID()
    let name: String
    let details: String
    let category: String
    let modifiers: [String]
    var sourceCode: String = ""
    let previewCode: String? = nil
    
    // Documentation links and references
    var documentationLinks: [String]? = nil
    var githubURL: String? = nil
}
