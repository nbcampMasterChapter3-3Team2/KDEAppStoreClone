//
//  HomeViewModel.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import Foundation
import RxSwift
import RxRelay

final class HomeViewModel: ViewModelProtocol {

    enum Action {
        case viewDidLoad
    }

    struct State {
        let springSong = BehaviorRelay<[Song]>(value: [])
        let summerSong = BehaviorRelay<[Song]>(value: [])
        let autumnSong = BehaviorRelay<[Song]>(value: [])
        let winterSong = BehaviorRelay<[Song]>(value: [])
    }

    // MARK: - Properties

    private let fetchSeasonSongUseCase: FetchSeasonSongUseCase
    let action = PublishRelay<Action>()
    var state = State()
    let disposeBag = DisposeBag()

    // MARK: - Init, Deinit, required

    init(fetchSeasonSongUseCase: FetchSeasonSongUseCase) {
        self.fetchSeasonSongUseCase = fetchSeasonSongUseCase
        bindActions()
    }

    // MARK: - Methods

    func bindActions() {
        action.bind { [weak self] action in
            switch action {
            case .viewDidLoad:
                self?.fetchAllSeasonSong()
            }
        }
        .disposed(by: disposeBag)
    }

    private func fetchAllSeasonSong() {
        // 계절별 추천곡 로드 병렬 처리
        Observable.merge(
            Season.allCases.map { season in
                fetchSeasonSongUseCase.execute(season: season)
                    .map { songs in (season, songs) }
            }
        )
        .subscribe { [weak self] season, songs in
            switch season {
            case .spring: self?.state.springSong.accept(songs)
            case .summer: self?.state.summerSong.accept(songs)
            case .autumn: self?.state.autumnSong.accept(songs)
            case .winter: self?.state.winterSong.accept(songs)
            }
        }
        .disposed(by: disposeBag)
    }
}
