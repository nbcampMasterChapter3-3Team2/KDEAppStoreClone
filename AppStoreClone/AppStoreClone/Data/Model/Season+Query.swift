//
//  Season+Query.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation

extension Season {
    var queryTerm: String {
        switch self {
        case .spring:
            return "spring+봄"
        case .summer:
            return "summer+여름"
        case .autumn:
            return "autumn+가을"
        case .winter:
            return "winter+겨울"
        }
    }

    var resultLimit: Int {
        switch self {
        case .spring: return 5
        default: return 20
        }
    }
}
