//
//  Nib.swift
//  App
//
//  Created by Daniel de Souza Ribas on 24/10/22.
//

import UIKit

protocol Nib: AnyObject {}

extension UIViewController: Nib {}
extension UIView: Nib {}

extension Nib where Self: UIView {
  static var reuseIdentifer: String { String(describing: MovieSummaryTableViewCell.self) }

  static var nib: UINib { UINib(nibName: reuseIdentifer, bundle: nil) }
}
