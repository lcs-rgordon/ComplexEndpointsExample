//
//  AuthorDetailResponse.swift
//  ComplexEndpointsExample
//
//  Created by Russell Gordon on 2025-05-25.
//

import Foundation

struct AuthorDetailResponse: Codable {
    
    // MARK: Stored properties
    let name: String
    let links: [AuthorLinkResponse]?
    let fullName: String?
    let birthDate: String?
//    let biography: String?
    
    // MARK: Enumeration(s)
    enum CodingKeys: String, CodingKey {
        
        case name
        case links
        case fullName = "fuller_name"
        case birthDate = "birth_date"
//        case biography = "bio"
    }
}

struct AuthorLinkResponse: Codable {
    
    // MARK: Stored properties
    let title: String
    let url: String
}
