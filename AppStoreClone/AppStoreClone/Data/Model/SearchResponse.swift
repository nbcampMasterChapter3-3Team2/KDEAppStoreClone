//
//  SearchResponse.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/14/25.
//

import Foundation

struct SearchResponse<T: Decodable>: Decodable {
    let results: [T]
}
