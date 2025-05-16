//
//  ImageLoader.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/12/25.
//

import UIKit
import RxSwift

final class ImageLoader {
    static let shared = ImageLoader()

    private init() {}

    func loadImage(from urlString: String) -> Single<UIImage?> {
        let bigImageURLString = urlString.replacingOccurrences(
            of: "30x30bb.jpg",
            with: "1024x1024bb.jpg"
        )
        guard let url = URL(string: bigImageURLString) else {
            return Single.create { observer in
                observer(.failure(ImageLoadError.invalidURL))
                return Disposables.create()
            }
        }

        return Single.create { observer in
            Task {
                do {
                    let (data, _ ) = try await URLSession.shared.data(from: url)
                    let image = UIImage(data: data)
                    observer(.success(image))
                } catch {
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

extension ImageLoader {
    enum ImageLoadError: Error {
        case invalidURL
    }
}
