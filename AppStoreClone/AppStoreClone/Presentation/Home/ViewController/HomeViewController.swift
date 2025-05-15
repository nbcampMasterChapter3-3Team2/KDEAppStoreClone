//
//  HomeViewController.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import UIKit
import Then
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()

    // TODO: DIContainer 구현
    private let searchRepository = DefaultSearchRepository(iTunesService: ITunesService())
    private lazy var fetchShowUseCase = FetchShowUseCase(repository: searchRepository)
    private lazy var searchResultViewModel = SearchResultViewModel(fetchShowUseCase: fetchShowUseCase)
    private lazy var searchResultViewController = SearchResultViewController(viewModel: searchResultViewModel)

    // MARK: - UI Components

    private lazy var searchController = UISearchController(searchResultsController: searchResultViewController).then {
        $0.searchBar.placeholder = "영화, 팟캐스트"
        $0.searchResultsUpdater = self
    }
    private let homeView = HomeView()

    // MARK: - Init, Deinit, required

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - View Life Cycles

    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setSearchController()
        bind()
    }

    // MARK: - Set Style

    private func setStyle() {
        title = "Music"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Set SearchController
    private func setSearchController() {
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }

    // MARK: - Bind

    private func bind() {
        viewModel.action.accept(.viewDidLoad)

        viewModel.state.springSong
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, songs in
                owner.homeView.updateSnapshot(with: songs, toSection: .spring)
            }
            .disposed(by: disposeBag)

        viewModel.state.summerSong
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, songs in
                owner.homeView.updateSnapshot(with: songs, toSection: .summer)
            }
            .disposed(by: disposeBag)

        viewModel.state.autumnSong
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, songs in
                owner.homeView.updateSnapshot(with: songs, toSection: .autumn)
            }
            .disposed(by: disposeBag)

        viewModel.state.winterSong
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, songs in
                owner.homeView.updateSnapshot(with: songs, toSection: .winter)
            }
            .disposed(by: disposeBag)

        searchResultViewController.didTapHeader
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, _ in
                owner.searchController.isActive = false
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        searchController.showsSearchResultsController = !query.isEmpty
        searchResultViewController.updateQuery(query)
    }
}
