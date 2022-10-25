//
//  MovieDetailPresenter.swift
//  App
//
//  Created by Daniel de Souza Ribas on 07/06/22.
//

import Foundation
import RxSwift

class MovieDetailPresenter {
  init(repository: MoviesRepository) {
    self.repository = repository
  }

  let repository: MoviesRepository
  let bag = DisposeBag()
  var view: MovieDetailViewController?

  func attachView(view: MovieDetailViewController) {
    self.view = view
  }

  func fetchMovieDetail(id: Int) {
    guard let view = view else {
      fatalError("Did not attach view")
    }

    view.startLoading()

    repository
      .getMovieDetail(id: id)
      .subscribe { movieDetail in
        view.stopLoading()
        view.showMovieDetail(with: movieDetail.toVM())
      } onFailure: { error in
        view.stopLoading()

        let appError = error as? AppError ?? .unexpected(baseError: error)
        view.showError(error: appError)
      }
      .disposed(by: bag)
  }
}
