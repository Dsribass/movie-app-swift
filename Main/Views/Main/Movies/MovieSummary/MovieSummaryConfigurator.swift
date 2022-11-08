//
//  MovieSummaryConfigurator.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import UIKit
import Swinject
import Domain
import Presentation

enum MovieSummaryConfigurator: ViewControllerConfigurator {
  static private var container = Container()

  static func setup(with container: Swinject.Container) {
    self.container = container

    container.register(MovieSummaryViewController.self) { resolver in
      MovieSummaryViewController(presenter: resolver.resolve(MovieSummaryPresenter.self)!)
    }

    container.register(MovieSummaryPresenter.self) { resolver in
      MovieSummaryPresenter(
        getMovieSummaryList: resolver.resolve(GetMovieSummaryList.self)!)
    }
  }

  static func getViewController(_ param: ()) -> MovieSummaryViewController {
    container.resolve(MovieSummaryViewController.self)!
  }
}