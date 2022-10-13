//
//  MainTabBarCoordinator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 13/10/22.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
  init() {
    self.mainTabBarViewController = MainTabBarViewController()
  }

  var children: [Coordinator] = []
  let mainTabBarViewController: MainTabBarViewController

  func start() {
    let movieCoordinator = createMovieCoordinator()
    children.append(movieCoordinator)
    movieCoordinator.start()

    let favoritesCoordinator = createFavoritesCoordinator()
    children.append(favoritesCoordinator)
    favoritesCoordinator.start()

    mainTabBarViewController.viewControllers = [
      movieCoordinator.navigationController,
      favoritesCoordinator.navigationController
    ]
  }

  private func createMovieCoordinator() -> MovieCoordinator {
    let movieNavigationController = UINavigationController()
    movieNavigationController.tabBarItem = createTabBarItem(title: "Filmes", imageName: "film")
    movieNavigationController.navigationItem.backButtonTitle = "Voltar"
    movieNavigationController.navigationBar.tintColor = .red
    return MovieCoordinator(navigationController: movieNavigationController)
  }

  private func createFavoritesCoordinator() -> FavoritesCoordinator {
    let favoritesNavigationController = UINavigationController()
    favoritesNavigationController.tabBarItem = createTabBarItem(title: "Favoritos", imageName: "star")
    return FavoritesCoordinator(navigationController: favoritesNavigationController)
  }

  private func createTabBarItem(title: String, imageName: String) -> UITabBarItem {
    let tabBarItem = UITabBarItem()
    tabBarItem.title = title
    tabBarItem.image = UIImage(systemName: imageName)
    return tabBarItem
  }
}
