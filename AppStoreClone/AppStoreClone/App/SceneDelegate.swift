//
//  SceneDelegate.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/9/25.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let service = ITunesService()
        let repository = DefaultSearchRepository(iTunesService: service)
        let useCase = FetchSeasonSongUseCase(repository: repository)
        let viewModel = HomeViewModel(fetchSeasonSongUseCase: useCase)
        let homeViewController = HomeViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

