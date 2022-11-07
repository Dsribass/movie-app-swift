//
//  FavoritesCoordinator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 13/10/22.
//

import UIKit

class FavoritesCoordinator: Coordinator {
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  var children: [Coordinator] = []
  var navigationController: UINavigationController

  func start() {
    let favoritesViewController = FavoriteMoviesConfigurator.getViewController(())
    navigationController.setViewControllers([favoritesViewController], animated: false)
  }
}
