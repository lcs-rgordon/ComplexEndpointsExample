//
//  AuthorSearchView.swift
//  ComplexEndpointsExample
//
//  Created by Russell Gordon on 2025-05-25.
//

import SwiftUI

struct AuthorSearchView: View {
    
    // MARK: Stored properties
    
    // Establish a connection to the view model for this view
    @State private var viewModel = AuthorSearchViewModel()
    
    // Hold the text typed into the search field
    @State private var searchText = ""
    
    // MARK: Computed properties
    var body: some View {
        NavigationStack {
            VStack {
                // Is there a response yet, from which to show results?
                if let currentResponse = viewModel.currentResponse {
                    
                    // Yes, so show those results
                    Text("To be implemented")
                    
                } else {
                    
                    // No, so show appropriate message
                    ContentUnavailableView(
                        "No results",
                        systemImage: "person.fill.questionmark",
                        description: Text("Provide an author name to get started")
                    )
                    
                }
            }
            .searchable(text: $searchText, prompt: "Enter name here")
            .navigationTitle("Author Search")
        }
    }
}

#Preview {
    AuthorSearchView()
}
