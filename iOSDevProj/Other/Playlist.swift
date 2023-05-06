//
//  Playlist.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/6/23.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
