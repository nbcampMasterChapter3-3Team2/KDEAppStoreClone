//
//  ITunesService.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation
import RxSwift

final class ITunesService {
    let baseURL = "https://itunes.apple.com/search?"

    func fetchSongSearchResult(term: String, limit: Int) -> Single<[SongDTO]> {
        let query = "media=music&entity=song&genreId=51&term=\(term)&limit=\(limit)"
        let urlString = baseURL + query

        guard let url = URL(string: urlString) else {
            return Single.create { observer in
                observer(.failure(ITunesServiceError.invalidURL))
                return Disposables.create()
            }
        }

        return Single.create { observer in
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let decodedData = try JSONDecoder().decode(SongResponse.self, from: data)
                    observer(.success(decodedData.results))
                } catch {
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

private extension ITunesService {
    enum ITunesServiceError: Error {
        case invalidURL
    }
}
