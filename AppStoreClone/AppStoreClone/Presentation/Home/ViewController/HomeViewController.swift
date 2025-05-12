//
//  HomeViewController.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()

    // MARK: - UI Components

    private let homeView = HomeView()

    // MARK: - Init, Deinit, required

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
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
        viewModel.action.accept(.viewDidLoad)
    }

    // MARK: - Bind

    private func bind() {
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
    }
}
