//
//  AuthorDocumentationResponseItemView.swift
//  ComplexEndpointsExample
//
//  Created by Russell Gordon on 2025-05-25.
//

import SwiftUI

struct AuthorDocumentationResponseItemView: View {
    
    // MARK: Stored properties
    
    // The author for which we want to show information
    let author: AuthorDocumentationResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(author.name)
                .font(.title2)
                .bold()
            Group {
                if let birthDate = author.birthDate {
                    Text("Authored \(author.workCount) works, born \(birthDate).")
                        .font(.caption)
                        .italic()
                } else {
                    Text("Authored \(author.workCount) works.")
                        .font(.caption)
                        .italic()
                }
            }
            .padding(.bottom, 5)

            VStack(alignment: .leading) {
                Text("Best known for: ")
                    .bold()
                HStack(spacing: 2) {
                    Text(author.topWork)
                    Spacer()
                }
            }
                        
        }
    }
}

#Preview {
    List {
        AuthorDocumentationResponseItemView(author: firstExample)
        AuthorDocumentationResponseItemView(author: secondExample)
    }
    .listStyle(.plain)
}
