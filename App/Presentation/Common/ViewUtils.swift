//
//  ViewUtils.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit
import Kingfisher

extension UIViewController {
  func setTabBarImage(imageName: String, title: String) {
    let image = UIImage(systemName: imageName)
    tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
  }
}

extension UIImageView {
  func setImageFrom(
    url: String,
    placeholderImage: UIImage?,
    handler: @escaping (_ imageResult: RetrieveImageResult) -> Void
  ) {
    if let url = URL(string: url) {
      kf.setImage(
        with: url,
        placeholder: placeholderImage,
        options: [.transition(.fade(0.2))]) { [unowned self] result in
          switch result {
          case .success(let imageResult):
            handler(imageResult)
          case .failure:
            image = placeholderImage
          }
      }
    } else {
      image = placeholderImage
    }
  }

  func setImageFrom(
    url: String,
    placeholderImage: UIImage?
  ) {
    if let url = URL(string: url) {
      kf.setImage(
        with: url,
        placeholder: placeholderImage,
        options: [.transition(.fade(0.2))])
    } else {
      image = placeholderImage
    }
  }
}

extension UIControl {
  func addAction(for event: UIControl.Event, handler: @escaping UIActionHandler) {
    self.addAction(UIAction(handler: handler), for: event)
  }
}
