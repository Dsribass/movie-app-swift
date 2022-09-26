//
//  ViewUtils.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit

extension UIViewController {
  func setTabBarImage(imageName: String, title: String) {
    let image = UIImage(systemName: imageName)
    tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
  }
}

extension UIImage {
  
  public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
    DispatchQueue.global().async {
      if let data = try? Data(contentsOf: url) {
        DispatchQueue.main.async {
          completion(UIImage(data: data))
        }
      } else {
        DispatchQueue.main.async {
          completion(nil)
        }
      }
    }
  }
  
}

extension UIControl {
  func addAction(for event: UIControl.Event, handler: @escaping UIActionHandler) {
    self.addAction(UIAction(handler:handler), for:event)
  }
}
