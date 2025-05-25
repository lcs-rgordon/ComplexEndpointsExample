//
//  AuthorSearchViewModel.swift
//  ComplexEndpointsExample
//
//  Created by Russell Gordon on 2025-05-25.
//

import Foundation
import OSLog

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
    
    // MARK: Function(s)
       
    // This retieves a response for a author search (by name) from the endpoint
    //
    // "async" means it is an asynchronous function.
    //
    // That means it can be run alongside other functionality
    // in our app. Since this function might take a while to complete
    // this ensures that other parts of our app, such as the user
    // interface, won't "freeze up" while this function does it's job.
    func fetchResults(for providedAuthorName: String) async {
        
        // 1. Attempt to create a URL from the required endpoint
        //
        //    e.g.:
        //
        //    https://openlibrary.org/search/authors.json?q=margaret%20atwood
        //
        //    SCHEME     HOST             PATH               QUERY ITEM(S)
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "openlibrary.org"
        urlComponents.path = "/search/authors.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: providedAuthorName)
        ]
        let endpoint = urlComponents.url!.absoluteString
        Logger.dataRetrieval.info("Assembled endpoint address is: \(endpoint).")
        guard let url = URL(string: endpoint) else {
            Logger.dataRetrieval.error("Invalid address for JSON endpoint.")
            return
        }
        
        // 2. Fetch the raw data from the URL
        //
        // Network requests can potentially fail (throw errors) so
        // we complete them within a do-catch block to report errors
        // if they occur.
        //
        do {
            
            // Fetch the data
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Print the received data in the debug console
            Logger.dataRetrieval.info("Got data from endpoint, contents of response are:")
            Logger.dataRetrieval.info("-------------------------------------------------")
            Logger.dataRetrieval.info("\(String(data: data, encoding: .utf8)!)")
            Logger.dataRetrieval.info("-------------------------------------------------")

            // 3. Decode the data into a Swift data type
            
            // Create a decoder object to do most of the work for us
            let decoder = JSONDecoder()
            
            // Use the decoder object to convert the raw data
            // into an instance of our Swift data type
            let decodedData = try decoder.decode(AuthorSearchResponse.self, from: data)
            
            // If we got here, decoding succeeded,
            // return the instance of our data type
            self.currentResponse = decodedData
            
        } catch {
            
            // Show an error that we wrote and understand
            Logger.dataRetrieval.error("Could not retrieve data from endpoint, or could not decode into an instance of a Swift data type.")
            Logger.dataRetrieval.error("----- detailed error message follows -----")
            Logger.dataRetrieval.error("\(error)")
            Logger.dataRetrieval.error("----- END of detailed error message -----")

        }
    }
}
