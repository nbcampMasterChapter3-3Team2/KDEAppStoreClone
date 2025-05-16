//
//  DetailViewModel.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/16/25.
//

import Foundation
import RxSwift
import RxRelay

final class DetailViewModel: ViewModelProtocol {
    enum Action {}

    struct State {
        let webViewURL = BehaviorRelay<URL?>(value: nil)
    }

    // MARK: - Properties

    var action = PublishRelay<Action>()
    var state = State()
    let disposeBag = DisposeBag()

    // MARK: - Init, Deinit, required

    init(webViewURL: URL) {
        state.webViewURL.accept(webViewURL)
    }
}
