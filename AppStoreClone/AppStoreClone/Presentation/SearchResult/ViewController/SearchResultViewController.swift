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
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, index in
                owner.viewModel.action.accept(.didSelectCell(index))
            }
            .disposed(by: disposeBag)

        viewModel.state.searchKeyword
            .bind(with: self) { owner, keyword in
                owner.searchResultView.headerTitle.accept(keyword)
            }
            .disposed(by: disposeBag)

        viewModel.state.show
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, shows in
                owner.searchResultView.updateSnapshot(with: shows, toSection: .show)
            }
            .disposed(by: disposeBag)

        viewModel.state.selectedShowURL
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, url in
                owner.present(DetailViewController(url: url), animated: true)
            }
            .disposed(by: disposeBag)

        searchResultView.didTapHeader
            .subscribe { [weak self] _ in
                self?.didTapHeader.accept(())
            }
            .disposed(by: disposeBag)
    }

    // MARK: - Methods

    func updateQuery(_ query: String) {
        viewModel.action.accept(.didQueryChanged(query))
    }
}
