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
        case didSelectedSong(IndexPath)
    }

    struct State {
        let springSong = BehaviorRelay<[Song]>(value: [])
        let summerSong = BehaviorRelay<[Song]>(value: [])
        let autumnSong = BehaviorRelay<[Song]>(value: [])
        let winterSong = BehaviorRelay<[Song]>(value: [])
        let selectedSong = PublishRelay<URL>()
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
            case .didSelectedSong(let indexPath):
                self?.getSelectedSongDetailViewURL(indexPath: indexPath)
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

    private func getSelectedSongDetailViewURL(indexPath: IndexPath) {
        let season = Season.allCases[indexPath.section]
        let song: Song?
        switch season {
        case .spring: song = state.springSong.value[indexPath.item]
        case .summer: song = state.summerSong.value[indexPath.item]
        case .autumn: song = state.autumnSong.value[indexPath.item]
        case .winter: song = state.winterSong.value[indexPath.item]
        }
        guard let song else { return }
        guard let urlString = song.detailViewURL, let url = URL(string: urlString) else { return }
        state.selectedSong.accept(url)
    }
}
