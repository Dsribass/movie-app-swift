//
//  MovieDetailPresenter.swift
//  App
//
//  Created by Daniel de Souza Ribas on 07/06/22.
//

import RxSwift
import Domain

class MovieDetailPresenter {
  enum States {
    case loading, error(DomainError), movieDetail(MovieDetailViewModel)
    case favoriteMovie, unfavoriteMovie
  }

  private let getMovieDetail: GetMovieDetail
  private let favoriteMovie: FavoriteMovie
  private let unfavoriteMovie: UnfavoriteMovie
  private let bag = DisposeBag()
  private let onNewStateSubject = BehaviorSubject<States>(value: .loading)

  var states: Observable<States> { onNewStateSubject }

  init(
    getMovieDetail: GetMovieDetail,
    favoriteMovie: FavoriteMovie,
    unfavoriteMovie: UnfavoriteMovie
  ) {
    self.getMovieDetail = getMovieDetail
    self.favoriteMovie = favoriteMovie
    self.unfavoriteMovie = unfavoriteMovie
  }


  func fetchMovieDetail(id: Int) {
    onNewStateSubject.onNext(.loading)

    getMovieDetail.execute(with: GetMovieDetail.Request(id: id))
      .map { MovieDetailViewModel(movieDetail: $0) }
      .subscribe { [unowned self] movieDetail in
        onNewStateSubject.onNext(.movieDetail(movieDetail))
      } onFailure: { [unowned self] error in
        let domainError = error as? DomainError ?? .unexpected(baseError: error)
        onNewStateSubject.onNext(.error(domainError))
      }
      .disposed(by: bag)
  }

  func favoriteMovie(with id: Int) {
    favoriteMovie.execute(with: FavoriteMovie.Request(id: id))
      .subscribe { [unowned self] _ in
        onNewStateSubject.onNext(.favoriteMovie)
      }
      .disposed(by: bag)
  }

  func unfavoriteMovie(with id: Int) {
    unfavoriteMovie.execute(with: UnfavoriteMovie.Request(id: id))
      .subscribe { [unowned self] _ in
        onNewStateSubject.onNext(.unfavoriteMovie)
      }
      .disposed(by: bag)
  }
}
