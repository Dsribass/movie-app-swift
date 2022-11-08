//
//  CoordinatorContainer.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 01/11/22.
//

import Swinject

enum CoordinatorContainer {
  static func build(with parentContainer: Container) -> Container {
    let container = Container(parent: parentContainer)
    MainTabBarConfigurator.setup(with: container)
    return container
  }
}
