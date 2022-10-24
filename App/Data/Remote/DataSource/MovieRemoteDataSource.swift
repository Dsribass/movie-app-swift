//
//  MovieRemoteDataSource.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation
import RxSwift
import Moya
import RxMoya

class MovieRemoteDataSource {
  init(provider: MoyaProvider<MovieProvider>) {
    self.provider = provider
  }

  let provider: MoyaProvider<MovieProvider>

  func getMovieSummaryList() -> Single<[MovieSummaryRM]> {
    provider.rx
      .request(.getMovieSummaryList)
      .mapAppError()
      .map([MovieSummaryRM].self, using: getJSONDecoder())
  }

  func getMovieDetail(id: Int) -> Single<MovieDetailRM> {
    provider.rx
      .request(.getMovieDetail(id: id))
      .mapAppError()
      .map(MovieDetailRM.self, using: getJSONDecoder())
  }

  private func getJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    decoder.dateDecodingStrategy = .formatted(formatter)
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    return decoder
  }
}
