//
//  GetMovieSummaryList.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import RxSwift

public final class GetMovieSummaryList: SingleUseCase {
  public init(repository: MoviesRepositoryProtocol) {
    self.repository = repository
  }

  private let repository: MoviesRepositoryProtocol

  public func execute(with req: Void) -> Single<[MovieSummary]> {
    repository.getMovieSummaryList(onlyFavoriteMovies: false)
  }
}
