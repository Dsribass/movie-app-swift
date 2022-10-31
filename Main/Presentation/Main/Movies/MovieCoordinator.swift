//
//  MovieCoordinator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 13/10/22.
//

import UIKit

class MovieCoordinator: Coordinator {
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  var navigationController: UINavigationController

  func start() {
    let movieSummaryViewController = MovieSummaryConfigurator.getViewController(())
    movieSummaryViewController.navigation = self
    navigationController.setViewControllers([movieSummaryViewController], animated: false)
  }
}

extension MovieCoordinator: MovieNavigation {
  func detailMovie(withId id: Int) {
    let movieDetailViewController = MovieDetailConfigurator.getViewController(
      MovieDetailViewControllerParameters(id: id))
    navigationController.pushViewController(movieDetailViewController, animated: true)
  }
}
