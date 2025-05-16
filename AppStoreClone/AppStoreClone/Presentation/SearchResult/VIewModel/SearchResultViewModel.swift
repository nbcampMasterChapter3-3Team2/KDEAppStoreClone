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
        case didSelectCell(Int)
    }

    struct State {
        let searchKeyword = BehaviorRelay<String>(value: "")
        let show = BehaviorRelay<[Show]>(value: [])
        let selectedShowURL = PublishRelay<URL>()
        let noDetailView = PublishRelay<Void>()
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
            guard let self else { return }
            switch action {
            case .didQueryChanged(let query):
                setSearchKeyword(for: query)
                fetchShow(by: query)
            case .didSelectCell(let index):
                setSelectedShowURL(for: index)
            }
        }
        .disposed(by: disposeBag)
    }

    private func setSearchKeyword(for keyword: String) {
        state.searchKeyword.accept(keyword)
    }

    private func fetchShow(by query: String) {
        fetchShowUseCase.execute(searchQuery: query)
            .subscribe { [weak self] shows in
                guard let self else { return }
                state.show.accept(shows)
            }
            .disposed(by: disposeBag)
    }

    private func setSelectedShowURL(for index: Int) {
        let selectedShow = state.show.value[index]
        guard let urlString = selectedShow.detailViewURL else {
            state.noDetailView.accept(())
            return
        }
        guard let url = URL(string: urlString) else { return }
        state.selectedShowURL.accept(url)
    }
}
