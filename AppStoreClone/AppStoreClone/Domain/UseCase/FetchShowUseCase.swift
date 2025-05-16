//
//  FetchShowUseCase.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/13/25.
//

import Foundation
import RxSwift

final class FetchShowUseCase {
    let repository: SearchRepository

    init(repository: SearchRepository) {
        self.repository = repository
    }

    func execute(searchQuery: String) -> Observable<[Show]> {
        repository.searchShow(by: searchQuery).asObservable()
    }
}
