//
//  DataContainer.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 01/11/22.
//

import Swinject

enum DataContainer {
  static func build(with parentContainer: Container) -> Container {
    let container = Container(parent: parentContainer)
    RemoteConfigurator.setup(with: container)
    CacheConfigurator.setup(with: container)
    RepositoryConfigurator.setup(with: container)

    return container
  }
}
