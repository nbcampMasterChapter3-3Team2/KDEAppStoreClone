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
    private var cache = NSCache<NSString, UIImage>()

    private init() {}


    func loadImage(from urlString: String) -> Single<UIImage?> {
        let bigImageURLString = urlString.replacingOccurrences(
            of: "30x30bb.jpg",
            with: "1024x1024bb.jpg"
        )

        if let cachedImage = cache.object(forKey: bigImageURLString as NSString) {
            return .just(cachedImage)
        }

        guard let url = URL(string: bigImageURLString) else {
            return Single.create { observer in
                observer(.failure(ImageLoadError.invalidURL))
                return Disposables.create()
            }
        }

        return Single.create { observer in
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data else { return }
                guard let image = UIImage(data: data) else {
                    observer(.success(nil))
                    return
                }
                self?.cache.setObject(image, forKey: bigImageURLString as NSString)
                observer(.success(image))
            }

            task.resume()

            return Disposables.create()
        }
    }
}

extension ImageLoader {
    enum ImageLoadError: Error {
        case invalidURL
    }
}
