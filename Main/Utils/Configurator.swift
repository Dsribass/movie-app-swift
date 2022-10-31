//
//  Configurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import UIKit
import Swinject

protocol Configurator {
  static func setup(with container: Container)
}

protocol CoordinatorConfigurator: Configurator {
  associatedtype CoordinatorType
  static func getCoordinator(with navigationController: UINavigationController) -> CoordinatorType
}

protocol ViewControllerConfigurator: Configurator {
  associatedtype ViewControllerType
  associatedtype ViewControllerParameter
  static func getViewController(_ param: ViewControllerParameter) -> ViewControllerType
}
