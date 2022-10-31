//
//  MainConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 28/10/22.
//
import UIKit
import Swinject

enum MainTabBarConfigurator: CoordinatorConfigurator {
  static var container = Container()

  static func setup(with container: Container) {
    self.container = container
    container.register(MainTabBarCoordinator.self) { _, nav in
      MainTabBarCoordinator(navigationController: nav)
    }
    .initCompleted { _, _ in
      MovieConfigurator.setup(with: container)
      FavoritesConfigurator.setup(with: container)
    }
  }

  static func getCoordinator(with navigationController: UINavigationController) -> MainTabBarCoordinator {
    container.resolve(MainTabBarCoordinator.self, argument: navigationController)!
  }
}
