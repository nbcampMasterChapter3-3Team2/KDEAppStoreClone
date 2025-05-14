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
                // TODO: observable들을 반환하는 메서드로 변경해서 concat으로 묶기
                self?.fetchSpringSong()
                self?.fetchSummerSong()
                self?.fetchAutumnSong()
                self?.fetchWinterSong()
            }
        }
        .disposed(by: disposeBag)
    }

    private func fetchSpringSong() {
        fetchSeasonSongUseCase.execute(season: .spring)
            .subscribe { [weak self] songs in
                self?.state.springSong.accept(songs)
            }
            .disposed(by: disposeBag)
    }

    private func fetchSummerSong() {
        fetchSeasonSongUseCase.execute(season: .summer)
            .subscribe { [weak self] songs in
                self?.state.summerSong.accept(songs)
            }
            .disposed(by: disposeBag)
    }

    private func fetchAutumnSong() {
        fetchSeasonSongUseCase.execute(season: .autumn)
            .subscribe { [weak self] songs in
                self?.state.autumnSong.accept(songs)
            }
            .disposed(by: disposeBag)
    }

    private func fetchWinterSong() {
        fetchSeasonSongUseCase.execute(season: .winter)
            .subscribe { [weak self] songs in
                self?.state.winterSong.accept(songs)
            }
            .disposed(by: disposeBag)
    }
}
