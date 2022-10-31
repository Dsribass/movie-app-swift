//
//  MainTabBarCoordinator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 13/10/22.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  var children: [Coordinator] = []
  var navigationController: UINavigationController

  func start() {
    let tabBar = MainTabBarViewController()

    let movieCoordinator = createMovieCoordinator()
    children.append(movieCoordinator)
    movieCoordinator.start()

    let favoritesCoordinator = createFavoritesCoordinator()
    children.append(favoritesCoordinator)
    favoritesCoordinator.start()

    tabBar.viewControllers = [
      movieCoordinator.navigationController,
      favoritesCoordinator.navigationController
    ]

    navigationController.setViewControllers([tabBar], animated: false)
  }

  private func createMovieCoordinator() -> MovieCoordinator {
    let navController = UINavigationController()
    navController.tabBarItem = createTabBarItem(title: "Filmes", imageName: "film")
    navController.navigationBar.tintColor = .red
    navController.navigationBar.prefersLargeTitles = true
    return MovieConfigurator.getCoordinator(with: navController)
  }

  private func createFavoritesCoordinator() -> FavoritesCoordinator {
    let navController = UINavigationController()
    navController.navigationBar.prefersLargeTitles = true
    navController.tabBarItem = createTabBarItem(title: "Favoritos", imageName: "star")
    return FavoritesConfigurator.getCoordinator(with: navController)
  }

  private func createTabBarItem(title: String, imageName: String) -> UITabBarItem {
    let tabBarItem = UITabBarItem()
    tabBarItem.title = title
    tabBarItem.image = UIImage(systemName: imageName)
    return tabBarItem
  }
}
