//
//  SongResponse+DTO.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation

struct SongResponse: Decodable {
    let results: [SongDTO]
}

struct SongDTO: Decodable {
    let trackName: String
    let artistName: String
    let artworkURL: String

    enum CodingKeys: String, CodingKey {
        case trackName
        case artistName
        case artworkURL = "artworkUrl30"
    }
}
