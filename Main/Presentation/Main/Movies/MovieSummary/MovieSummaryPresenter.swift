//
//  MovieSummaryVM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/05/22.
//

import Domain
import RxSwift

class MovieSummaryPresenter {
  init(getMovieSummaryList: GetMovieSummaryList) {
    self.getMovieSummaryList = getMovieSummaryList
  }

  private let getMovieSummaryList: GetMovieSummaryList
  private let bag = DisposeBag()

  weak var view: MovieSummaryViewController?

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
