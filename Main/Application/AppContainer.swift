//
//  AppConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 28/10/22.
//

import Swinject
import Domain

enum AppContainer {
  static func build() -> Container {
    let mainContainer = Container()
    let dataContainer = DataContainer.build(with: mainContainer)
    let domainContainer = DomainContainer.build(with: dataContainer)
    let coordinatorContainer = CoordinatorContainer.build(with: domainContainer)
    return coordinatorContainer
  }
}
