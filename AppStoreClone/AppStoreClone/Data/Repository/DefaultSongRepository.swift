//
//  DefaultSongRepository.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation
import RxSwift

final class DefaultSongRepository: SongRepository {
    let iTunesService: ITunesService

    init(iTunesService: ITunesService) {
        self.iTunesService = iTunesService
    }

    func searchSong(season: Season) -> Single<[Song]> {
        iTunesService.fetchSongSearchResult(term: season.queryTerm)
            .map { $0.map(SongMapper.map) }
    }
}
