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
        guard let url = URL(string: urlString) else { return nil }
        guard let (data, _ ) = try? await URLSession.shared.data(from: url) else { return nil }
        return UIImage(data: data)
    }
}
