//
//  ErrorView.swift
//  App
//
//  Created by Daniel de Souza Ribas on 27/06/22.
//

import UIKit

class ErrorView: UIView {
  var message: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.textColor = .black
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.numberOfLines = 0
    label.sizeToFit()
    
    return label
  }()
  
  var button: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .systemRed
    button.tintColor = .white
    button.layer.cornerRadius = 20
    
    return button
  }()
  
  override init(frame:CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ErrorView {
  private func setupLayout() {
    addSubview(message)
    addSubview(button)
    
    NSLayoutConstraint.activate([
      message.topAnchor.constraint(equalTo: self.topAnchor),
      message.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      message.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    ])
    
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 30),
      button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      button.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
}
