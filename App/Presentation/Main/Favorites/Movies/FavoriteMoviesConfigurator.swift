//
//  FavoriteMoviesConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import UIKit
import Swinject

enum FavoriteMoviesConfigurator: ViewControllerConfigurator {
  static private var container = Container()

  static func setup(with container: Swinject.Container) {
    self.container = container
    container.register(FavoriteMoviesPresenter.self) { resolver in
      FavoriteMoviesPresenter(repository: resolver.resolve(MoviesRepository.self)!)
    }

    container.register(FavoriteMoviesViewController.self) { resolver in
      FavoriteMoviesViewController(presenter: resolver.resolve(FavoriteMoviesPresenter.self)!)
    }
  }

  static func getViewController(_ param: ()) -> FavoriteMoviesViewController {
    container.resolve(FavoriteMoviesViewController.self)!
  }
}
