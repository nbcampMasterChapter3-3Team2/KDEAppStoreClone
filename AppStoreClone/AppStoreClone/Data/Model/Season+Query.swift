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
            return "spring"
        case .summer:
            return "summer"
        case .autumn:
            return "autumn"
        case .winter:
            return "winter"
        }
    }
}
