//
//  Factory.swift
//  App
//
//  Created by Daniel de Souza Ribas on 09/06/22.
//

enum Factory {
  // MARK: Remote
  static func makeMoyaAdapter() -> MoyaAdapter<MovieService> {
    return MoyaAdapter<MovieService>()
  }

  static func makeMovieRemoteDataSource() -> MovieRemoteDataSource {
    return MovieRemoteDataSource(adapter: makeMoyaAdapter())
  }

  // MARK: Repository
  static func makeMovieRepository() -> MoviesRepository {
    return MoviesRepository(movieRDS: makeMovieRemoteDataSource())
  }

  // MARK: Presenter
  static func makeMovieSummaryPresenter() -> MovieSummaryPresenter {
    return MovieSummaryPresenter(repository: makeMovieRepository())
  }

  static func makeMovieDetailPresenter() -> MovieDetailPresenter {
    return MovieDetailPresenter(repository: makeMovieRepository())
  }

  // MARK: ViewControllers
  static func makeMovieSummaryViewController() -> MovieSummaryViewController {
    return MovieSummaryViewController(presenter: makeMovieSummaryPresenter())
  }

  static func makeMovieDetailViewController(id: Int) -> MovieDetailViewController {
    return MovieDetailViewController(
      presenter: makeMovieDetailPresenter(),
      id: id)
  }

  static func makeFavoritesViewController() -> FavoritesViewController {
    return FavoritesViewController()
  }
}
