//
//  MovieSummaryPresenter.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/05/22.
//

import Domain
import RxSwift

class MovieSummaryPresenter {
  enum States {
    case loading, error(DomainError), movies([MovieSummaryViewModel])
  }

  private let bag = DisposeBag()
  private let getMovieSummaryList: GetMovieSummaryList
  private let onNewStateSubject = BehaviorSubject<States>(value: .loading)

  var states: Observable<States> { onNewStateSubject }

  init(getMovieSummaryList: GetMovieSummaryList) {
    self.getMovieSummaryList = getMovieSummaryList
  }

  func fetchMovieSummaryList() {
    onNewStateSubject.onNext(.loading)

    getMovieSummaryList.execute(with: ())
      .map { $0.map { movie in MovieSummaryViewModel(movie: movie) } }
      .subscribe { [unowned self] movieSummaryList in
        onNewStateSubject.onNext(.movies(movieSummaryList))
      } onFailure: { [unowned self] error in
        let domainError = error as? DomainError ?? .unexpected(baseError: error)
        onNewStateSubject.onNext(.error(domainError))
      }
      .disposed(by: bag)
  }
}
