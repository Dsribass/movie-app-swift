//
//  MovieRemoteDataSource.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation

class MovieRemoteDataSource {
  init(adapter: MoyaAdapter<MovieService>) {
    self.moyaAdapter = adapter
  }

  let moyaAdapter: MoyaAdapter<MovieService>

  func getMovieSummaryList() async -> Result<[MovieSummaryRM], AppError> {
    return await withCheckedContinuation { continuation in
      moyaAdapter.request(target: .getMovieSummaryList) { result in
        switch result {
        case .success(let response):
          let decodedDataResult = self.moyaAdapter.tryDecodeData(
            from: response.data,
            with: self.getJSONDecoder()
          ) as Result<[MovieSummaryRM], AppError>
          continuation.resume(returning: decodedDataResult)
        case .failure(let error):
          continuation.resume(returning: .failure(error))
        }
      }
    }
  }

  func getMovieDetail(id: Int) async -> Result<MovieDetailRM, AppError> {
    return await withCheckedContinuation { continuation in
      moyaAdapter.request(target: .getMovieDetail(id: id)) { result in
        switch result {
        case .success(let response):
          let decodedDataResult = self.moyaAdapter.tryDecodeData(
            from: response.data,
            with: self.getJSONDecoder()
          ) as Result<MovieDetailRM, AppError>
          continuation.resume(returning: decodedDataResult)
        case .failure(let error):
          continuation.resume(returning: .failure(error))
        }
      }
    }
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
