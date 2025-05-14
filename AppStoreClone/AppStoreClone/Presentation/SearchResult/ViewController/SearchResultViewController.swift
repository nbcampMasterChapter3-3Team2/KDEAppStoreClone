//
//  SearchResultViewController.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/13/25.
//

import UIKit

final class SearchResultViewController: UIViewController {

    private let searchResultView = SearchResultView()

    override func loadView() {
        view = searchResultView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
