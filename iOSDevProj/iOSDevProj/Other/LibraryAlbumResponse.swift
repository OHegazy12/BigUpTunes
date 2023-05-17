//
//  LibraryAlbumResponse.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/15/23.
//

import Foundation

struct LibraryAlbumResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
