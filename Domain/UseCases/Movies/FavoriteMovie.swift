//
//  FavoriteMovie.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 01/11/22.
//

import RxSwift

public protocol FavoriteMovieUseCase {
  func execute(with req: FavoriteMovie.Request) -> Completable
}

public final class FavoriteMovie: FavoriteMovieUseCase {
  public init(repository: MoviesDataRepository) {
    self.repository = repository
  }

  private let repository: MoviesDataRepository

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
