//
//  UIImageView+Extension.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/12/25.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        print(url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { [weak self] data, _, _ in
            guard let data else { return }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
}
