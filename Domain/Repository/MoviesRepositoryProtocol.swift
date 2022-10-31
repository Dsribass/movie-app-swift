//
//  MoviesRepositoryProtocol.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import RxSwift

public protocol MoviesRepositoryProtocol {
  func getMovieSummaryList(onlyFavoriteMovies: Bool) -> Single<[MovieSummary]>

  func getMovieDetail(id: Int) -> Single<MovieDetail>

  func favoriteMovie(with id: Int) -> Completable

  func unfavoriteMovie(with id: Int) -> Completable
}
