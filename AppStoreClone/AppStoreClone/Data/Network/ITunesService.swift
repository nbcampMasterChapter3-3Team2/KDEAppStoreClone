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

    func fetch<T: Decodable>(type: SearchMediaType) -> Single<[T]> {
        let urlString = baseURL + type.query

        guard let url = URL(string: urlString) else {
            return Single.create { observer in
                observer(.failure(ITunesServiceError.invalidURL))
                return Disposables.create()
            }
        }

        return Single.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                do {
                    guard let data else { return }
                    let decodedData = try JSONDecoder().decode(SearchResponse<T>.self, from: data)
                    observer(.success(decodedData.results))
                } catch {
                    observer(.failure(error))
                }
            }

            task.resume()

            return Disposables.create()
        }
    }
}

private extension ITunesService {
    enum ITunesServiceError: Error {
        case invalidURL
    }
}
