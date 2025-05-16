//
//  SearchRepository.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation
import RxSwift

protocol SearchRepository {
    func searchSong(season: Season) -> Single<[Song]>
    func searchShow(by term: String) -> Single<[Show]>
}
