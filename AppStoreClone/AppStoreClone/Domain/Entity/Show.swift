//
//  Show.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/13/25.
//

import Foundation

struct Show: Hashable {
    let kind: ShowKind
    let title: String
    let artist: String
    let artworkImageURL: String
    let genre: String
    let releaseDate: Date
    let detailViewURL: String?
}
