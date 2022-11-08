//
//  ExternalModuleContainer.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 01/11/22.
//

import Swinject
import Domain
import Data

enum DomainContainer {
  static func build(with parentContainer: Container) -> Container {
    let container = Container(parent: parentContainer)
    DomainConfigurator.setup(with: container)
    return container
  }

  private enum DomainConfigurator: Configurator {
    static func setup(with container: Container) {
      container.register(GetMovieSummaryList.self) { resolver in
        GetMovieSummaryList(repository: resolver.resolve(MoviesRepository.self)!)
      }

      container.register(GetFavoriteMovies.self) { resolver in
        GetFavoriteMovies(repository: resolver.resolve(MoviesRepository.self)!)
      }

      container.register(GetMovieDetail.self) { resolver in
        GetMovieDetail(repository: resolver.resolve(MoviesRepository.self)!)
      }

      container.register(FavoriteMovie.self) { resolver in
        FavoriteMovie(repository: resolver.resolve(MoviesRepository.self)!)
      }

      container.register(UnfavoriteMovie.self) { resolver in
        UnfavoriteMovie(repository: resolver.resolve(MoviesRepository.self)!)
      }
    }
  }
}
