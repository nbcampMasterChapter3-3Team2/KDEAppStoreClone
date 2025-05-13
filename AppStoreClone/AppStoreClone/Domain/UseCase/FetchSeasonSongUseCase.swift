//
//  FetchSeasonSongUseCase.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation
import RxSwift

final class FetchSeasonSongUseCase {
    let repository: SearchRepository

    init(repository: SearchRepository) {
        self.repository = repository
    }

    func execute(season: Season) -> Observable<[Song]> {
        repository.searchSong(season: season).asObservable()
    }
}
