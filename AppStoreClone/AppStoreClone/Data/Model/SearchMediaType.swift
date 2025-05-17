//
//  SearchType.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/14/25.
//

import Foundation

enum SearchMediaType {
    case music(Season)
    case movie(String)
    case podcast(String)

    var query: String {
        switch self {
        case .music(let season):
            let searchTerm = season.queryTerm
            let limit = season.resultLimit
            return "media=music&entity=song&genreId=51&term=\(searchTerm)&limit=\(limit)"
        case .movie(let searchTerm):
            return "media=movie&entity=movie&term=\(searchTerm)&limit=20"
        case .podcast(let searchTerm):
            return "media=podcast&entity=podcast&term=\(searchTerm)&limit=20"
        }
    }
}
