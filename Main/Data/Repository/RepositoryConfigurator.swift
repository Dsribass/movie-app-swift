//
//  RepositoryConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 28/10/22.
//

import Swinject

enum RepositoryConfigurator: Configurator {
  static func setup(with container: Container) {
    container.register(MoviesRepository.self) { resolver in
      MoviesRepository(
        movieRDS: resolver.resolve(MovieRemoteDataSource.self)!,
        userPreferencesCDS: resolver.resolve(UserPreferencesCacheDataSource.self)!)
    }
  }
}
