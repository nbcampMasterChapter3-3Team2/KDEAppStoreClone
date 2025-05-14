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
        let term = season.queryTerm.replacingOccurrences(of: " ", with: "+")
        return iTunesService.fetchSongSearchResult(term: term, limit: season.resultLimit)
            .map { $0.map(SongMapper.map) }
    }
}
