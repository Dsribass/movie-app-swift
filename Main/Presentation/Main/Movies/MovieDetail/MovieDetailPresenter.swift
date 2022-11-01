//
//  MovieDetailPresenter.swift
//  App
//
//  Created by Daniel de Souza Ribas on 07/06/22.
//

import RxSwift
import Domain

protocol MovieDetailPresenterActions {
  func fetchMovieDetail(id: Int)
  func favoriteMovie(with id: Int)
  func unfavoriteMovie(with id: Int)
}

class MovieDetailPresenter: MovieDetailPresenterActions {
  init(
    getMovieDetail: GetMovieDetail,
    favoriteMovie: FavoriteMovie,
    unfavoriteMovie: UnfavoriteMovie
  ) {
    self.getMovieDetail = getMovieDetail
    self.favoriteMovie = favoriteMovie
    self.unfavoriteMovie = unfavoriteMovie
  }

  private let getMovieDetail: GetMovieDetail
  private let favoriteMovie: FavoriteMovie
  private let unfavoriteMovie: UnfavoriteMovie
  private let bag = DisposeBag()

  var view: MovieDetailViewState?

  func fetchMovieDetail(id: Int) {
    guard let view = view else {
      fatalError("Did not attach view")
    }

    view.startLoading()

    getMovieDetail.execute(with: GetMovieDetail.Request(id: id))
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
  
  func favoriteMovie(with id: Int) {
    guard let view = view else {
      fatalError("Did not attach view")
    }

    favoriteMovie.execute(with: FavoriteMovie.Request(id: id))
      .subscribe {
        view.showFavoriteImage()
      } onError: { error in
        print(error)
      }
      .disposed(by: bag)
  }

  func unfavoriteMovie(with id: Int) {
    guard let view = view else {
      fatalError("Did not attach view")
    }

    unfavoriteMovie.execute(with: UnfavoriteMovie.Request(id: id))
      .subscribe {
        view.showUnfavoriteImage()
      } onError: { error in
        print(error)
      }
      .disposed(by: bag)
  }
}
