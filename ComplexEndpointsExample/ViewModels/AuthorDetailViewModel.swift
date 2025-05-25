//
//  AuthorDetailViewModel.swift
//  ComplexEndpointsExample
//
//  Created by Russell Gordon on 2025-05-25.
//

import Foundation
import OSLog

@Observable
class AuthorDetailViewModel {
    
    // MARK: Stored properties
    
    // Whatever response has most recently been received
    // from the endpoint
    var currentResponse: AuthorDetailResponse?
    
    // MARK: Initializer(s)
    init(forAuthorWithId id: String) {
        
        // Initially, we won't have details yet, so set the property to nil
        self.currentResponse = nil
        
        // Go out and fetch details for this author
        Task {
            await self.fetchDetails(forAuthorWithId: id)
        }
    }
    
    // MARK: Function(s)
       
    // This retrieves a response providing details for a given author,
    // based on their unique identifier in the Open Library system.
    //
    // "async" means it is an asynchronous function.
    //
    // That means it can be run alongside other functionality
    // in our app. Since this function might take a while to complete
    // this ensures that other parts of our app, such as the user
    // interface, won't "freeze up" while this function does it's job.
    //
    // "private" means this function can only be called inside this class.
    // The view will never need to call this function, so to prevent
    // unintentional use of this function from the view, we hide it by marking
    // it as "private".
    private func fetchDetails(forAuthorWithId id: String) async {
        
        // 1. Attempt to create a URL from the required endpoint
        //
        //    e.g.:
        //
        //    https://openlibrary.org/authors/OL52922A.json
        //
        //    SCHEME     HOST               PATH
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "openlibrary.org"
        urlComponents.path = "/authors/\(id).json"          // Use the provided id to
                                                            // construct the path
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
            let decodedData = try decoder.decode(AuthorDetailResponse.self, from: data)
            
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
