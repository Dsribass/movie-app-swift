//
//  ViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 25/10/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
  let bag = DisposeBag()

  let onTryAgainSubject = PublishSubject<Void>()
  var onTryAgain: Observable<Void> { onTryAgainSubject }
}
