//
//  AuthorSearchViewModel.swift
//  ComplexEndpointsExample
//
//  Created by Russell Gordon on 2025-05-25.
//

import Foundation

@Observable
class AuthorSearchViewModel {
    
    // MARK: Stored properties
    
    // Whatever response has most recently been received
    // from the endpoint
    var currentResponse: AuthorSearchResponse?
    
    // MARK: Initializer(s)
    init() {
        
        // When the view model is first created, there
        // will be no search active, so the current response
        // from the endpoint won't exist yet (it will be nil)
        self.currentResponse = nil
    }
    
}
