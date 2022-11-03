//
//  Factory.swift
//  App
//
//  Created by Daniel de Souza Ribas on 09/06/22.
//

import Moya

enum Factory {
  // MARK: Data
  static func makeMoyaProvider<ProviderType>() -> MoyaProvider<ProviderType> {
    return MoyaProvider<ProviderType>()
  }

  static func makeUserPreferencesCacheDataSource() -> UserPreferencesCacheDataSource {
    return UserPreferencesCacheDataSource()
  }

  static func makeMovieRemoteDataSource() -> MovieRemoteDataSource {
    return MovieRemoteDataSource(provider: makeMoyaProvider())
  }

  static func makeMovieRepository() -> MoviesRepository {
    return MoviesRepository(
      movieRDS: makeMovieRemoteDataSource(),
      userPreferencesCDS: makeUserPreferencesCacheDataSource())
  }

  // MARK: Presenter
  static func makeMovieSummaryPresenter() -> MovieSummaryPresenter {
    return MovieSummaryPresenter(repository: makeMovieRepository())
  }

  static func makeMovieDetailPresenter() -> MovieDetailPresenter {
    return MovieDetailPresenter(repository: makeMovieRepository())
  }

  static func makeFavoritesPresenter() -> FavoritesPresenter {
    return FavoritesPresenter(repository: makeMovieRepository())
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
    return FavoritesViewController(presenter: makeFavoritesPresenter())
  }
}
