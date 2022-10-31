//
//  CacheConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 28/10/22.
//

import Swinject

enum CacheConfigurator: Configurator {
  static func setup(with container: Container) {
    container.register(UserPreferencesCacheDataSource.self) { _ in
      UserPreferencesCacheDataSource()
    }
  }
}
