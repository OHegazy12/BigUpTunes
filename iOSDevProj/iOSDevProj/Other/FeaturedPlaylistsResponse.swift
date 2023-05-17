//
//  FeaturedPlaylistsResponse.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/6/23.
//

import Foundation


struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct CategoryPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
    
}
