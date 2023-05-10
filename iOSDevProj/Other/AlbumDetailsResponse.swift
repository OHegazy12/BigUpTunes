//
//  AlbumDetailsResponse.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/10/23.
//

import Foundation

struct AlbumDetailsResponse: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let tracks: TracksResponse
    let name: String
}

struct TracksResponse: Codable {
    let items: [AudioTrack]
}
