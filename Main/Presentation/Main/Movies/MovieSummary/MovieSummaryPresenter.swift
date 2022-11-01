//
//  MovieSummaryVM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/05/22.
//

import Domain
import RxSwift

protocol MovieSummaryPresenterActions {
  func fetchMovieSummaryList()
}

class MovieSummaryPresenter: MovieSummaryPresenterActions {
  init(getMovieSummaryList: GetMovieSummaryList) {
    self.getMovieSummaryList = getMovieSummaryList
  }

  private let getMovieSummaryList: GetMovieSummaryList
  private let bag = DisposeBag()

  var view: MovieSummaryViewState?

  func fetchMovieSummaryList() {
    guard let view = view else {
      fatalError("Did not attach view")
    }

    view.startLoading()

    getMovieSummaryList.execute(with: ())
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
