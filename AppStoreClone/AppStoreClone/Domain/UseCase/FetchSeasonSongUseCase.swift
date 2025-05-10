//
//  FetchSeasonSongUseCase.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation
import RxSwift

final class FetchSeasonSongUseCase {
    let songRepository: SongRepository

    init(songRepository: SongRepository) {
        self.songRepository = songRepository
    }

    func execute(season: Season) -> Observable<[Song]> {
        songRepository.searchSong(season: season).asObservable()
    }
}
