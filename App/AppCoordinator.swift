//
//  AppCoordinator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/10/22.
//

import UIKit
import Swinject

class AppCoordinator: Coordinator {
  init(window: UIWindow) {
    self.window = window
  }

  private let window: UIWindow
  var children: [Coordinator] = []
  var container = Container()

  func start() {
    container = AppContainer.build()

    let nav = UINavigationController()
    nav.isNavigationBarHidden = true
    let mainTabBarCoordinator = MainTabBarConfigurator.getCoordinator(with: nav)
    children.append(mainTabBarCoordinator)

    window.rootViewController = nav
    window.makeKeyAndVisible()

    mainTabBarCoordinator.start()
  }
}
