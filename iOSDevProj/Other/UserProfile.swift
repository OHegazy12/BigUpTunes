//
//  UserProfile.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/1/23.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let product: String
    let images: [APIImage]
}
