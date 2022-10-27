//
//  MovieSummaryVM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/05/22.
//

import Foundation

class MovieSummaryPresenter {
  init(repository: MoviesRepository) {
    self.repository = repository
  }

  private let repository: MoviesRepository
  private var view: MovieSummaryViewController?

  func attachView(view: MovieSummaryViewController) {
    self.view = view
  }

  func fetchMovieSummaryList() async {
    guard let view = view else {
      fatalError("Did not attach view")
    }

    await view.startLoading()

    let result = await repository.getMovieSummaryList()

    switch result {
    case .success(let list):
      await view.stopLoading()
      await view.showSuccess(success: list)
    case .failure(let error):
      await view.stopLoading()
      await view.showError(error: error)
    }
  }
}
