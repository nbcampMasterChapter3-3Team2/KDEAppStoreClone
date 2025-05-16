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
        let album = dto.collectionName
        let detailViewURL = dto.detailViewURL
        return Song(
            title: title,
            artist: artist,
            artworkImageURL: artworkURL,
            album: album,
            detailViewURL: detailViewURL,
        )
    }
}
