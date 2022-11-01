//
//  FavoritesPresenter.swift
//  App
//
//  Created by Daniel de Souza Ribas on 27/10/22.
//

import Foundation
import RxSwift
import Domain

class FavoriteMoviesPresenter {
  init(
    getFavoriteMovies: GetFavoriteMovies,
    unfavoriteMovie: UnfavoriteMovie
  ) {
    self.getFavoriteMovies = getFavoriteMovies
    self.unfavoriteMovie = unfavoriteMovie
  }

  private let getFavoriteMovies: GetFavoriteMovies
  private let unfavoriteMovie: UnfavoriteMovie
  private let bag = DisposeBag()

  var view: FavoriteMoviesViewController?

  func fetchFavoriteMovies() {
    guard let view = view else {
      fatalError("Did not attach view")
    }

    view.startLoading()

    getFavoriteMovies.execute(with: ())
      .subscribe { movieSummaryList in
        view.stopLoading()
        view.showFavoriteMovies(with: movieSummaryList)
      } onFailure: { error in
        view.stopLoading()

        let appError = error as? AppError ?? .unexpected(baseError: error)
        view.showError(error: appError)
      }
      .disposed(by: bag)
  }

  func unfavoriteMovie(with id: Int) {
    guard let view = view else {
      fatalError("Did not attach view")
    }

    unfavoriteMovie.execute(with: UnfavoriteMovie.Request(id: id))
      .subscribe {
        view.removeFavoriteMovieFromTableView(with: id)
      } onError: { error in
        print(error)
      }
      .disposed(by: bag)
  }
}
