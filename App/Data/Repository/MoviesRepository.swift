//
//  MoviesRepository.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation

class MoviesRepository {
  init(movieRDS: MovieRemoteDataSource) {
    self.movieRDS = movieRDS
  }

  let movieRDS: MovieRemoteDataSource

  func getMovieSummaryList() async -> Result<[MovieSummary], AppError> {
    do {
      let movies = try await movieRDS
        .getMovieSummaryList()
        .value
        .toDM()
      return .success(movies)
    } catch let error as AppError {
      return .failure(error)
    } catch {
      return .failure(.unexpected(baseError: error))
    }
  }

  func getMovieDetail(id: Int) async -> Result<MovieDetail, AppError> {
    do {
      let movieDetail = try await movieRDS
        .getMovieDetail(id: id)
        .value
        .toDM()
      return .success(movieDetail)
    } catch let error as AppError {
      return .failure(error)
    } catch {
      return .failure(.unexpected(baseError: error))
    }
  }
}
