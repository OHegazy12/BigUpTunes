//
//  Artist.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/6/23.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
    let images: [APIImage]?
}
