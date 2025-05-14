//
//  DefaultSongRepository.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation
import RxSwift

final class DefaultSearchRepository: SearchRepository {
    let iTunesService: ITunesService

    init(iTunesService: ITunesService) {
        self.iTunesService = iTunesService
    }

    func searchSong(season: Season) -> Single<[Song]> {
        return iTunesService.fetch(type: .music(season))
            .map { $0.map(SongMapper.map) }
    }

    func searchShow(by term: String) -> Single<[Show]> {
        let movie = iTunesService.fetch(type: .movie(term))
            .map { $0.compactMap(ShowMapper.map)}
        let podcast = iTunesService.fetch(type: .podcast(term))
            .map { $0.compactMap(ShowMapper.map)}

        return Single.zip(movie, podcast).map { movies, podcasts in
            (movies + podcasts).sorted { $0.releaseDate > $1.releaseDate }
        }
    }

}
