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
        viewModel.state.show
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, shows in
                owner.searchResultView.updateSnapshot(with: shows, toSection: .show)
            }
            .disposed(by: disposeBag)
    }

    // MARK: - Methods

    func updateQuery(_ query: String) {
        viewModel.action.accept(.didQueryChanged(query))
    }
}
