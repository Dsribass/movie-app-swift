//
//  FavoriteMovie.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 01/11/22.
//

import RxSwift

public final class FavoriteMovie: CompletableUseCase {
  public init(repository: MoviesRepositoryProtocol) {
    self.repository = repository
  }

  private let repository: MoviesRepositoryProtocol

  public func execute(with req: Request) -> Completable {
    repository.favoriteMovie(with: req.id)
  }
}

public extension FavoriteMovie {
  struct Request {
    public init(id: Int) {
      self.id = id
    }

    public let id: Int
  }
}
