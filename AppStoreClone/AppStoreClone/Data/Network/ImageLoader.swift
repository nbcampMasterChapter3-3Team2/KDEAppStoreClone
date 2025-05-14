//
//  ImageLoader.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/12/25.
//

import Foundation
import UIKit

final class ImageLoader {
    static let shared = ImageLoader()

    private init() {}

    func loadImage(from urlString: String) async -> UIImage? {
        let bigImageURLString = urlString.replacingOccurrences(of: "30x30bb.jpg", with: "1024x1024bb.jpg")
        guard let url = URL(string: bigImageURLString) else { return nil }
        guard let (data, _ ) = try? await URLSession.shared.data(from: url) else { return nil }
        return UIImage(data: data)
    }
}
