//
//  ApplicationCoordinator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/10/22.
//

import UIKit

class AppCoordinator: Coordinator {
  init(window: UIWindow) {
    self.window = window
  }

  private let window: UIWindow
  var children: [Coordinator] = []

  func start() {
    let mainTabBarCoordinator = MainTabBarCoordinator()
    mainTabBarCoordinator.start()

    children.append(mainTabBarCoordinator)
    window.rootViewController = mainTabBarCoordinator.mainTabBarViewController
    window.makeKeyAndVisible()
  }
}
