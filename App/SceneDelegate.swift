//
//  SceneDelegate.swift
//  App
//
//  Created by Daniel de Souza Ribas on 10/05/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  var applicationCoordinator: AppCoordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let window = createUIWindow(scene: scene) else {
      return
    }
    let applicationCoordinator = AppCoordinator(window: window)
    applicationCoordinator.start()

    self.window = window
    self.applicationCoordinator = applicationCoordinator
  }

  private func createUIWindow(scene: UIScene) -> UIWindow? {
    guard let windowScene = (scene as? UIWindowScene) else { return nil }
    let window = UIWindow(windowScene: windowScene)
    window.frame = UIScreen.main.bounds

    return window
  }
}
