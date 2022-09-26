//
//  SceneDelegate.swift
//  App
//
//  Created by Daniel de Souza Ribas on 10/05/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    window = getAppWindow(windowScene: windowScene)
  }

  private func getAppWindow(windowScene: UIWindowScene) -> UIWindow {
    let mainTabVarViewController = MainTabBarViewController(
      movieSummaryViewController: Factory.makeMovieSummaryViewController(),
      favoritesViewController: Factory.makeFavoritesViewController())

    let safeWindow = UIWindow(windowScene: windowScene)
    safeWindow.frame = UIScreen.main.bounds
    safeWindow.makeKeyAndVisible()
    safeWindow.rootViewController = mainTabVarViewController

    return safeWindow
  }
}
