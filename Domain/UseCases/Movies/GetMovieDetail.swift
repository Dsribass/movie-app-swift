//
//  GetMovieDetail.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 01/11/22.
//

import RxSwift

public protocol GetMovieDetailUseCase {
  func execute(with req: GetMovieDetail.Request) -> Single<MovieDetail>
}

public final class GetMovieDetail: GetMovieDetailUseCase {
  public init(repository: MoviesDataRepository) {
    self.repository = repository
  }

  private let repository: MoviesDataRepository

  public func execute(with req: GetMovieDetail.Request) -> Single<MovieDetail> {
    repository.getMovieDetail(id: req.id)
  }
}

public extension GetMovieDetail {
  struct Request {
    public init(id: Int) {
      self.id = id
    }

    public let id: Int
  }
}
