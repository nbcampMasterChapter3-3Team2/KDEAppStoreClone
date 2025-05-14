//
//  ShowMapper.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/14/25.
//

import Foundation

struct ShowMapper {
    static func map(_ dto: ShowDTO) -> Show? {
        let kind: ShowKind = dto.kind == "podcast" ? .podcast : .movie
        let title = dto.trackName
        let artist = dto.artistName
        let artworkURL = dto.artworkURL
        let genre = dto.primaryGenreName

        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: dto.releaseDate) else { return nil }

        return Show(
            kind: kind,
            title: title,
            artist: artist,
            artworkURL: artworkURL,
            genre: genre,
            releaseDate: date
        )
    }
}
