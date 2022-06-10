//
//  SceneDelegate.swift
//  App
//
//  Created by Daniel de Souza Ribas on 10/05/22.
//

import UIKit

// TODO: Implement Dependency Injection

let appNetwork = AppNetwork()
let movieRDS = MovieRemoteDataSource(appNetwork: appNetwork)
let repository = MoviesRepository(movieRDS: movieRDS)

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let factory = Factory()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        window = getAppWindow(windowScene: windowScene);
    }
    
    private func getAppWindow(windowScene: UIWindowScene) -> UIWindow {
        let mainTabVarViewController = MainTabBarViewController(
            movieSummaryViewController: factory.makeMovieSummaryViewController(),
            favoritesViewController: FavoritesViewController()
        )
        let safeWindow = UIWindow(windowScene: windowScene)
        safeWindow.frame = UIScreen.main.bounds
        safeWindow.makeKeyAndVisible()
        safeWindow.rootViewController = mainTabVarViewController
        
        return safeWindow
    }
}

