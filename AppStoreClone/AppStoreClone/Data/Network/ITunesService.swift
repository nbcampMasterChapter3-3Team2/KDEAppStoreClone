//
//  ITunesService.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation
import RxSwift

enum ITunesServiceError: Error {
    case invalidURL
    case dataFetchFail
    case decodeFail
}

final class ITunesService {
    let baseURL = "https://itunes.apple.com/search?"

    func fetchSongSearchResult(term: String) -> Single<[SongDTO]> {
        let term = term.replacingOccurrences(of: " ", with: "+")
        let query = "media=music&entity=song&term=\(term)"
        let urlString = baseURL + query

        guard let url = URL(string: urlString) else {
            return Single.create { observer in
                observer(.failure(ITunesServiceError.invalidURL))
                return Disposables.create()
            }
        }

        return Single.create { observer in
            let session = URLSession(configuration: .default)
            session.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error {
                    observer(.failure(error))
                }

                guard let data, let response = response as? HTTPURLResponse else {
                    observer(.failure(ITunesServiceError.dataFetchFail))
                    return
                }

                guard let decodedData = try? JSONDecoder().decode(SongResponse.self, from: data) else {
                    observer(.failure(ITunesServiceError.decodeFail))
                    return
                }

                observer(.success(decodedData.results))
            }.resume()
            
            return Disposables.create()
        }
    }
}
