//
//  SongRepository.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation
import RxSwift

protocol SongRepository {
    func searchSong(season: Season) -> Single<[Song]>
}
