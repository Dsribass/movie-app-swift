//
//  MovieSummaryVM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/05/22.
//

import Foundation
import RxSwift

class MovieSummaryPresenter {
  init(repository: MoviesRepository) {
    self.repository = repository
  }

  private let repository: MoviesRepository
  private let bag = DisposeBag()
  weak var view: MovieSummaryViewController?

  func fetchMovieSummaryList() {
    guard let view = view else {
      fatalError("Did not attach view")
    }

    view.startLoading()

    repository
      .getMovieSummaryList()
      .subscribe { movieSummaryList in
        view.stopLoading()
        view.showMovieSummaryList(with: movieSummaryList)
      } onFailure: { error in
        view.stopLoading()

        let appError = error as? AppError ?? .unexpected(baseError: error)
        view.showError(error: appError)
      }
      .disposed(by: bag)
  }
}
