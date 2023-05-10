//
//  PlaylistDetailsResponse.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/10/23.
//

import Foundation

struct PlaylistDetailsResponse: Codable {
    let description: String
    let external_urls: [String: String]
    let images: [APIImage]
    let name: String
    let id: String
    let tracks: PlaylistTracksResponse
}

struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}
