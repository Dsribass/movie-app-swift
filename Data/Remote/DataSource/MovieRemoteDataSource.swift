//
//  MovieRemoteDataSource.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation
import RxSwift
import RxMoya

public class MovieRemoteDataSource {
  public init(provider: MoyaAdapter<MovieProvider>) {
    self.provider = provider
  }

  let provider: MoyaAdapter<MovieProvider>

  func getMovieSummaryList() -> Single<[MovieSummaryRM]> {
    provider
      .request(.getMovieSummaryList)
      .map([MovieSummaryRM].self, using: getJSONDecoder())
  }

  func getMovieDetail(id: Int) -> Single<MovieDetailRM> {
    provider
      .request(.getMovieDetail(id: id))
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
