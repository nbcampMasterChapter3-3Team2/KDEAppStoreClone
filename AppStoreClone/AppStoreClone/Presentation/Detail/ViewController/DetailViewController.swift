//
//  DetailViewController.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/16/25.
//

import WebKit
import SnapKit
import Then
import RxSwift

final class DetailViewController: UIViewController, WKUIDelegate {

    // MARK: - Properties

    private let viewModel: DetailViewModel
    private let disposeBag = DisposeBag()

    // MARK: - UI Components

    var webView: WKWebView?

    // MARK: - Init, Deinit, required

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycles

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    // MARK: - Bind

    private func bind() {
        viewModel.state.webViewURL
            .compactMap { $0 }
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: loadWebView)
            .disposed(by: disposeBag)

    }

    private func loadWebView(of url: URL) {
        let request = URLRequest(url: url)
        if let webView {
            webView.load(request)
        }
    }
}
