//
//  SearchResultViewController.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/13/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchResultViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: SearchResultViewModel
    let didTapHeader = PublishRelay<Void>()
    private let disposeBag = DisposeBag()

    // MARK: - UI Components

    private let searchResultView = SearchResultView()

    // MARK: - Init, Deinit, required

    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycles

    override func loadView() {
        view = searchResultView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    // MARK: - Bind

    private func bind() {
        searchResultView.didSelectedCell
            .map(SearchResultViewModel.Action.didSelectCell)
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)

        viewModel.state.searchKeyword
            .bind(onNext: searchResultView.headerTitle.accept)
            .disposed(by: disposeBag)

        viewModel.state.show
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, shows in
                owner.searchResultView.updateSnapshot(with: shows, toSection: .show)
            }
            .disposed(by: disposeBag)

        viewModel.state.selectedShowURL
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, url in
                let viewModel = DetailViewModel(webViewURL: url)
                let viewController = DetailViewController(viewModel: viewModel)
                owner.present(viewController, animated: true)
            }
            .disposed(by: disposeBag)

        viewModel.state.noDetailView
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: showAlert)
            .disposed(by: disposeBag)

        searchResultView.didTapHeader
            .bind(to: didTapHeader)
            .disposed(by: disposeBag)
    }

    // MARK: - Methods

    func updateQuery(_ query: String) {
        viewModel.action.accept(.didQueryChanged(query))
    }

    private func showAlert() {
        let alert = UIAlertController(title: "알림", message: "상세페이지가 없습니다.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
}
