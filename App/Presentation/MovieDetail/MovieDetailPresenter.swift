//
//  MovieDetailPresenter.swift
//  App
//
//  Created by Daniel de Souza Ribas on 07/06/22.
//

import Foundation

class MovieDetailPresenter {
  init(repository: MoviesRepository) {
    self.repository = repository
  }

  let repository: MoviesRepository
  var view: MovieDetailViewController?

  func attachView(view: MovieDetailViewController) {
    self.view = view
  }

  func fetchMovieDetail(id: Int) async {
    guard let view = view else {
      fatalError("Did not attach view")
    }

    await view.startLoading()

    let result = await repository.getMovieDetail(id: id)

    switch result {
    case .success(let movie):
      await view.stopLoading()
      await view.showSuccess(success: movie.toVM())
    case .failure:
      await view.stopLoading()
      await view.showError()
    }
  }
}
