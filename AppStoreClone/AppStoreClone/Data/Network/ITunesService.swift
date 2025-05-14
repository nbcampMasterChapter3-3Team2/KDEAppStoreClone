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
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let decodedData = try JSONDecoder().decode(SearchResponse<T>.self, from: data)
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
