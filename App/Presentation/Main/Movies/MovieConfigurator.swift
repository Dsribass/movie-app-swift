//
//  MovieConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import UIKit
import Swinject

enum MovieConfigurator: CoordinatorConfigurator {
  static private var container = Container()

  static func setup(with container: Swinject.Container) {
    self.container = container
    container.register(MovieCoordinator.self) { _, navController in
      MovieCoordinator(navigationController: navController)
    }
    .initCompleted { _, _ in
      MovieSummaryConfigurator.setup(with: container)
      MovieDetailConfigurator.setup(with: container)
    }
  }

  static func getCoordinator(with navigationController: UINavigationController) -> MovieCoordinator {
    container.resolve(MovieCoordinator.self, argument: navigationController)!
  }
}
