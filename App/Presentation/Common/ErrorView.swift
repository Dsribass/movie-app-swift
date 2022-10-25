//
//  ErrorView.swift
//  App
//
//  Created by Daniel de Souza Ribas on 27/06/22.
//

import UIKit
import RxSwift
import RxCocoa

class ErrorView: UIView {
  init() {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  let bag = DisposeBag()

  var contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

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

  private let onTryAgainSubject = PublishSubject<Void>()
  var onTryAgain: Observable<Void> { onTryAgainSubject }

  func configure(message: String, buttonLabel: String) {
    self.message.text = message
    self.button.setTitle(buttonLabel, for: .normal)

    self.button.rx.tap
      .asObservable()
      .do(onNext: { [unowned self] _ in self.removeFromSuperview() })
      .bind(to: onTryAgainSubject)
      .disposed(by: bag)
  }

  private func setupLayout() {
    backgroundColor = .systemBackground

    addSubview(contentView)
    contentView.addSubview(message)
    contentView.addSubview(button)

    NSLayoutConstraint.activate([
      contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
      contentView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
      trailingAnchor.constraint(equalToSystemSpacingAfter: contentView.trailingAnchor, multiplier: 2)
    ])

    NSLayoutConstraint.activate([
      message.topAnchor.constraint(equalTo: contentView.topAnchor),
      message.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      message.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])

    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 30),
      button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      button.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
}
