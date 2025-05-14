//
//  Season+UI.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation

extension Season {
    var sectionTitle: String {
        switch self {
        case .spring: "봄 Best"
        case .summer: "여름"
        case .autumn: "가을"
        case .winter: "겨울"
        }
    }

    var sectionDescription: String {
        switch self {
        case .spring: "봄에 어울리는 음악 Best 5"
        case .summer: "여름에 어울리는 음악"
        case .autumn: "가을에 어울리는 음악"
        case .winter: "겨울에 어울리는 음악"
        }
    }
}
