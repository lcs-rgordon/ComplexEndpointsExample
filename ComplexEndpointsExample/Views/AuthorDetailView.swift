//
//  AuthorDetailView.swift
//  ComplexEndpointsExample
//
//  Created by Russell Gordon on 2025-05-25.
//

import SwiftUI

struct AuthorDetailView: View {
    
    // MARK: Stored properties
    
    // Receive an instance of our view model from the calling view
    let viewModel: AuthorDetailViewModel
    
    // Receive the author's name, so we can show it immediately as the navigation title
    let authorName: String
    
    // MARK: Computed properties
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Is there a response yet, from which to show result?
            if let currentResponse = viewModel.currentResponse {
                
                if let fullName = currentResponse.fullName {
                    LabelAndValueView(label: "Full name", value: fullName)
                }
                
                if let birthDate = currentResponse.birthDate {
                    LabelAndValueView(label: "Date of birth", value: birthDate)
                }

//                if let biography = currentResponse.biography {
//                    LabelAndValueView(label: "Biography", value: biography)
//                }

                Spacer()
            } else {
                ProgressView()
            }
        }
        .padding()
        .navigationTitle(authorName)
    }
}

#Preview {
    NavigationStack {
        // Get details for Margaret Atwood, whose Open Library unique identifier
        // is OL52922A
        AuthorDetailView(
            viewModel: AuthorDetailViewModel(forAuthorWithId: "OL52922A"),
            authorName: "Margaret Atwood"
        )
    }
    
}
