//
//  RemoteConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 28/10/22.
//

import Swinject
import Moya

enum RemoteConfigurator: Configurator {
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
