//
//  FavoritesPresenter.swift
//  App
//
//  Created by Daniel de Souza Ribas on 27/10/22.
//

import Foundation
import RxSwift
import Domain

public class FavoriteMoviesPresenter {
  public enum States {
    case loading, error(DomainError), favoriteMovies([FavoriteMovieViewModel])
    case unfavoriteMovie(id: Int)
  }

  private let getFavoriteMovies: GetFavoriteMovies
  private let unfavoriteMovie: UnfavoriteMovie
  private let bag = DisposeBag()
  private let onNewStateSubject = BehaviorSubject<States>(value: .loading)

  public var states: Observable<States> { onNewStateSubject }

  public init(
    getFavoriteMovies: GetFavoriteMovies,
    unfavoriteMovie: UnfavoriteMovie
  ) {
    self.getFavoriteMovies = getFavoriteMovies
    self.unfavoriteMovie = unfavoriteMovie
  }

  public func fetchFavoriteMovies() {
    onNewStateSubject.onNext(.loading)

    getFavoriteMovies.execute(with: ())
      .map { $0.map { movie in FavoriteMovieViewModel(movie: movie) } }
      .subscribe { [unowned self] movieSummaryList in
        onNewStateSubject.onNext(.favoriteMovies(movieSummaryList))
      } onFailure: { [unowned self] error in
        let domainError = error as? DomainError ?? .unexpected(baseError: error)
        onNewStateSubject.onNext(.error(domainError))
      }
      .disposed(by: bag)
  }

  public func unfavoriteMovie(with id: Int) {
    unfavoriteMovie.execute(with: UnfavoriteMovie.Request(id: id))
      .subscribe { [unowned self] _ in
        onNewStateSubject.onNext(.unfavoriteMovie(id: id))
      }
      .disposed(by: bag)
  }
}
