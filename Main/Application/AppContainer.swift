//
//  AppConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 28/10/22.
//

import Swinject

enum AppContainer {
  static func build() -> Container {
    let mainContainer = Container()
    let dataContainer = DataContainer.build(with: mainContainer)
    let coordinatorContainer = CoordinatorContainer.build(with: dataContainer)
    return coordinatorContainer
  }
}


private enum DataContainer {
  static func build(with parentContainer: Container) -> Container {
    let container = Container(parent: parentContainer)
    RemoteConfigurator.setup(with: container)
    CacheConfigurator.setup(with: container)
    RepositoryConfigurator.setup(with: container)

    return container
  }
}

private enum CoordinatorContainer {
  static func build(with parentContainer: Container) -> Container {
    let container = Container(parent: parentContainer)
    MainTabBarConfigurator.setup(with: container)
    return container
  }
}
