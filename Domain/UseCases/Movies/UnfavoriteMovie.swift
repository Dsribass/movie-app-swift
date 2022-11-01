//
//  UnfavoriteMovie.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 01/11/22.
//

import RxSwift

public final class UnfavoriteMovie: CompletableUseCase {
  public init(repository: MoviesDataRepository) {
    self.repository = repository
  }

  private let repository: MoviesDataRepository

  public func execute(with req: Request) -> Completable {
    repository.unfavoriteMovie(with: req.id)
  }
}

public extension UnfavoriteMovie {
  struct Request {
    public init(id: Int) {
      self.id = id
    }

    public let id: Int
  }
}
