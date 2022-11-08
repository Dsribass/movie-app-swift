//
//  MovieDetailConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import UIKit
import Swinject
import Domain
import Presentation

enum MovieDetailConfigurator: ViewControllerConfigurator {
  static private var container = Container()

  static func setup(with container: Swinject.Container) {
    self.container = container

    container.register(MovieDetailViewController.self) { (resolver, id: Int) in
      MovieDetailViewController(
        presenter: resolver.resolve(MovieDetailPresenter.self)!,
        id: id)
    }

    container.register(MovieDetailPresenter.self) { resolver in
      MovieDetailPresenter(
        getMovieDetail: resolver.resolve(GetMovieDetail.self)!,
        favoriteMovie: resolver.resolve(FavoriteMovie.self)!,
        unfavoriteMovie: resolver.resolve(UnfavoriteMovie.self)!
      )
    }
  }

  static func getViewController(_ param: MovieDetailViewControllerParameters) -> MovieDetailViewController {
    container.resolve(MovieDetailViewController.self, argument: param.id)!
  }
}

struct MovieDetailViewControllerParameters { let id: Int }
