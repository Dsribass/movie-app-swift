//
//  MovieDetailConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import UIKit
import Swinject
import Domain

enum MovieDetailConfigurator: ViewControllerConfigurator {
  static private var container = Container()

  static func setup(with container: Swinject.Container) {
    self.container = container
    var movieId: Int?

    container.register(MovieDetailViewController.self) { (resolver, id: Int) in
      movieId = id
      return MovieDetailViewController(
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
    .initCompleted { resolver, instance in
      let view = resolver.resolve(MovieDetailViewController.self, argument: movieId!)!
      instance.view = view
    }
  }

  static func getViewController(_ param: MovieDetailViewControllerParameters) -> MovieDetailViewController {
    container.resolve(MovieDetailViewController.self, argument: param.id)!
  }
}

struct MovieDetailViewControllerParameters { let id: Int }
