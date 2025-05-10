//
//  SongMapper.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation

struct SongMapper {
    static func map(_ dto: SongDTO) -> Song {
        let title = dto.trackName
        let artist = dto.artistName
        let artworkURL = dto.artworkURL
        return Song(title: title, artist: artist, artworkURL: artworkURL)
    }
}
