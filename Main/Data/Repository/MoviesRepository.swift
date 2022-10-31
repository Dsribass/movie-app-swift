//
//  MoviesRepository.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation
import RxSwift
import Domain

class MoviesRepository: MoviesRepositoryProtocol {
  init(
    movieRDS: MovieRemoteDataSource,
    userPreferencesCDS: UserPreferencesCacheDataSource
  ) {
    self.movieRDS = movieRDS
    self.userPreferencesCDS = userPreferencesCDS
  }

  let movieRDS: MovieRemoteDataSource
  let userPreferencesCDS: UserPreferencesCacheDataSource

  func getMovieSummaryList(onlyFavoriteMovies: Bool = false) -> Single<[MovieSummary]> {
    if onlyFavoriteMovies {
      return Single.zip(
        movieRDS.getMovieSummaryList(),
        userPreferencesCDS.getFavoriteMovies()
      )
      .map { movies, favoriteMoviesId in
        movies.filter { movie in favoriteMoviesId.contains { $0 == movie.id } }
      }
      .map { $0.toDM() }
    }

    return movieRDS
      .getMovieSummaryList()
      .map { $0.toDM() }
  }

  func getMovieDetail(id: Int) -> Single<MovieDetail> {
    Single.zip(
      movieRDS.getMovieDetail(id: id),
      userPreferencesCDS.getFavoriteMovies()
    )
    .flatMap { movieDetail, favoriteMoviesId -> Single<(movie: MovieDetailRM, isFavorite: Bool)> in
      let isFavorite = favoriteMoviesId.contains { $0 == movieDetail.id }

      return Single.just((movieDetail, isFavorite))
    }
    .map { $0.toDM(isFavorite: $1) }
  }

  func favoriteMovie(with id: Int) -> Completable {
    userPreferencesCDS.addFavoriteMovie(id: id)
  }

  func unfavoriteMovie(with id: Int) -> Completable {
    userPreferencesCDS.removeFavoriteMovie(id: id)
  }
}
