//
//  SearchResults.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/11/23.
//

import Foundation

enum SearchResults {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
