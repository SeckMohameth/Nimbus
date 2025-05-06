

//
//  ContributeView.swift
//  Nimbus
//
//  Created by Mohameth Seck on 1/9/25.
//

import SwiftUI

struct ContributeView: View {
    var body: some View {
        NavigationStack {
            List {
                // How to Contribute section
                Section(header: Text("How to Contribute")) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("We welcome contributions to Nimbus!")
                            .font(.headline)
                        
                        // Step-by-step contribution guide
                        Text("1. Fork the Repository")
                            .font(.subheadline)
                        Text("Visit our GitHub repo and create your fork")
                            .font(.caption)
                        
                        Text("2. Add Your Component")
                            .font(.subheadline)
                        Text("Create a new file in the appropriate category folder")
                            .font(.caption)
                        
                        Text("3. Update TopicData")
                            .font(.subheadline)
                        Text("Add your component to the topics list")
                            .font(.caption)
                        
                        Text("4. Create a Pull Request")
                            .font(.subheadline)
                        Text("Submit your changes for review")
                            .font(.caption)
                    }
                    .padding(.vertical)
                }
                
                // Links to resources
                Section(header: Text("Resources")) {
                    // GitHub repository link
                    Link(destination: URL(string: "https://github.com/SeckMohameth/Nimbus")!) {
                        HStack {
                            Image(systemName: "link")
                            Text("GitHub Repository")
                        }
                    }
                    
                    // Contributing guidelines link
                    Link(destination: URL(string: "https://github.com/SeckMohameth/Nimbus/blob/main/CONTRIBUTING.md")!) {
                        HStack {
                            Image(systemName: "doc.text")
                            Text("Contributing Guidelines")
                        }
                    }
                }
            }
            .navigationTitle("Contribute")
        }
    }
}

#Preview {
    ContributeView()
}

