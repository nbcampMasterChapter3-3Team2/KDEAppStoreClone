//
//  Show+UI.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/14/25.
//

import UIKit

extension Show {
    var color: UIColor {
        switch kind {
        case .movie: UIColor.brown.withAlphaComponent(0.2)
        case .podcast: UIColor.cyan.withAlphaComponent(0.2)
        }
    }
}
