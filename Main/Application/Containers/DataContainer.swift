//
//  DataContainer.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 01/11/22.
//

import Swinject
import Moya
import Data

public enum DataContainer {
  static func build(with parentContainer: Container) -> Container {
    let container = Container(parent: parentContainer)
    RemoteConfigurator.setup(with: container)
    CacheConfigurator.setup(with: container)
    RepositoryConfigurator.setup(with: container)

    return container
  }

  private enum CacheConfigurator: Configurator {
    static func setup(with container: Container) {
      container.register(UserPreferencesCacheDataSource.self) { _ in
        UserPreferencesCacheDataSource()
      }
    }
  }

  private enum RemoteConfigurator: Configurator {
    static func setup(with container: Container) {
      container.register(
        MoyaProvider.self,
        name: String(describing: MovieProvider.self)
      ) { _ in MoyaProvider<MovieProvider>() }

      container.register(MovieRemoteDataSource.self) { resolver in
        MovieRemoteDataSource(
          provider: resolver.resolve(
            MoyaProvider.self,
            name: String(describing: MovieProvider.self))!)
      }
    }
  }

  private enum RepositoryConfigurator: Configurator {
    static func setup(with container: Container) {
      container.register(MoviesRepository.self) { resolver in
        MoviesRepository(
          movieRDS: resolver.resolve(MovieRemoteDataSource.self)!,
          userPreferencesCDS: resolver.resolve(UserPreferencesCacheDataSource.self)!)
      }
    }
  }
}
