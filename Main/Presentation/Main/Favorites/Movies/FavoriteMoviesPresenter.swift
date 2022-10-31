//
//  FavoritesPresenter.swift
//  App
//
//  Created by Daniel de Souza Ribas on 27/10/22.
//

import Foundation
import RxSwift

class FavoriteMoviesPresenter {
  init(repository: MoviesRepository) {
    self.repository = repository
  }

  private let bag = DisposeBag()
  private let repository: MoviesRepository
  private var view: FavoriteMoviesViewController?

  func attachView(_ view: FavoriteMoviesViewController) {
    self.view = view
  }

  func fetchFavoriteMovies() {
    guard let view = view else {
      fatalError("Did not attach view")
    }

    view.startLoading()

    repository
      .getMovieSummaryList(onlyFavoriteMovies: true)
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

    repository
      .unfavoriteMovie(with: id)
      .subscribe {
        view.removeFavoriteMovieFromTableView(with: id)
      } onError: { error in
        print(error)
      }
      .disposed(by: bag)
  }
}
