//
//  SearchResultViewModel.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/14/25.
//

import Foundation
import RxSwift
import RxRelay

final class SearchResultViewModel: ViewModelProtocol {
    enum Action {
        case didQueryChanged(String)
    }

    struct State {
        let show = BehaviorRelay<[Show]>(value: [])
    }

    // MARK: - Properties

    private let fetchShowUseCase: FetchShowUseCase
    let action = PublishRelay<Action>()
    var state = State()
    let disposeBag = DisposeBag()

    // MARK: - Init, Deinit, required

    init(fetchShowUseCase: FetchShowUseCase) {
        self.fetchShowUseCase = fetchShowUseCase
        bindActions()
    }

    // MARK: - Methods

    func bindActions() {
        action.bind { [weak self] action in
            switch action {
            case .didQueryChanged(let query):
                self?.fetchShow(by: query)
            }
        }
        .disposed(by: disposeBag)
    }

    private func fetchShow(by query: String) {
        fetchShowUseCase.execute(searchQuery: query)
            .subscribe { [weak self] shows in
                self?.state.show.accept(shows)
            }
            .disposed(by: disposeBag)
    }
}
