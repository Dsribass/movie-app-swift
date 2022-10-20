//
//  MoviesRepository.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation
import RxSwift

class MoviesRepository {
  init(movieRDS: MovieRemoteDataSource) {
    self.movieRDS = movieRDS
  }

  let movieRDS: MovieRemoteDataSource

  func getMovieSummaryList() -> Single<[MovieSummary]> {
    movieRDS
      .getMovieSummaryList()
      .map { $0.toDM() }
  }

  func getMovieDetail(id: Int) -> Single<MovieDetail> {
    movieRDS
      .getMovieDetail(id: id)
      .map { $0.toDM() }
  }
}
