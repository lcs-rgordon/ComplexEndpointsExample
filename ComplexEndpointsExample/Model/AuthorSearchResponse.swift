//
//  AuthorSearchResponse.swift
//  ComplexEndpointsExample
//
//  Created by Russell Gordon on 2025-05-25.
//

import Foundation

struct AuthorSearchResponse: Codable {
    
    // MARK: Stored properties
    let hits: Int
    let docs: [AuthorDocumentationResponse]

    // MARK: Enumeration(s)
    enum CodingKeys: String, CodingKey {
        
        case hits = "numFound"
        case docs
    }

}

struct AuthorDocumentationResponse: Identifiable, Codable {
    
    // MARK: Stored properties
    let id: String
    let name: String
    let birthDate: String?
    let topWork: String
    let workCount: Int
    
    // MARK: Enumeration(s)
    enum CodingKeys: String, CodingKey {
        
        case id = "key"
        case name
        case birthDate = "birth_date"
        case topWork = "top_work"
        case workCount = "work_count"
        
    }
}

// Example data for previews
let firstExample = AuthorDocumentationResponse(
    id: "OL52922A",
    name: "Margaret Atwood",
    birthDate: "18 November 1939",
    topWork: "The Handmaid's Tale",
    workCount: 671
)

let secondExample = AuthorDocumentationResponse(
    id: "OL1922978A",
    name: "William Atwood",
    birthDate: nil,
    topWork: "The antiquity and justice of an oath of abjuration",
    workCount: 28
)
