//
//  FavoritesConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import UIKit
import Swinject

enum FavoritesConfigurator: CoordinatorConfigurator {
  static private var container = Container()

  static func setup(with container: Swinject.Container) {
    self.container = container
    container.register(FavoritesCoordinator.self) { _, navController in
      FavoritesCoordinator(navigationController: navController)
    }
    .initCompleted { _, _ in
      FavoriteMoviesConfigurator.setup(with: container)
    }
  }

  static func getCoordinator(
    with navigationController: UINavigationController
  ) -> FavoritesCoordinator {
    container.resolve(FavoritesCoordinator.self, argument: navigationController)!
  }
}
