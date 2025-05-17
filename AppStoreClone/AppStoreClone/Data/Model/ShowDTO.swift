//
//  ShowDTO.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/13/25.
//

import Foundation

struct ShowDTO: Decodable {
    let kind: String
    let trackName: String
    let artistName: String
    let artworkImageURL: String
    let primaryGenreName: String
    let releaseDate: String
    let webViewURL: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case trackName
        case artistName
        case artworkImageURL = "artworkUrl30"
        case primaryGenreName
        case releaseDate
        case webViewURL = "collectionViewUrl"
    }
}
