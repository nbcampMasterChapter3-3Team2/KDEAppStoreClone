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

    func fetchSongSearchResult(term: String) -> Single<[SongDTO]> {
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
                do {
                    if let error { throw error }

                    guard let data, let response = response as? HTTPURLResponse,
                          (200..<300).contains(response.statusCode) else {
                        throw ITunesServiceError.dataFetchFail
                    }

                    let decodedData = try JSONDecoder().decode(SongResponse.self, from: data)
                    observer(.success(decodedData.results))
                } catch let iTunesServiceError as ITunesServiceError {
                    observer(.failure(iTunesServiceError))
                    return
                } catch {
                    observer(.failure(error))
                    return
                }
            }.resume()
            return Disposables.create()
        }
    }
}

private extension ITunesService {
    enum ITunesServiceError: Error {
        case invalidURL
        case dataFetchFail
        case decodeFail
    }
}
