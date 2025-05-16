//
//  DetailViewController.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/16/25.
//

import WebKit
import SnapKit
import Then

final class DetailViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView?
    private let url: URL?

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url else { return }
        let request = URLRequest(url: url)
        if let webView {
            webView.load(request)
        }
    }

}
