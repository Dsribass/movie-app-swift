//
//  GetFavoriteMoviesList.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 01/11/22.
//

import RxSwift

public final class GetFavoriteMovies: SingleUseCase {
  public init(repository: MoviesDataRepository) {
    self.repository = repository
  }

  private let repository: MoviesDataRepository

  public func execute(with req: Void) -> Single<[MovieSummary]> {
    repository.getMovieSummaryList(onlyFavoriteMovies: true)
  }
}
