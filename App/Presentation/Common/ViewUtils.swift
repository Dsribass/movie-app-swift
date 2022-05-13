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
