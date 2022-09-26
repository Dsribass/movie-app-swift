//
//  MovieDetailMappers.swift
//  App
//
//  Created by Daniel de Souza Ribas on 21/09/22.
//

extension MovieDetail {
  func toVM() -> MovieDetailVM {
    return MovieDetailVM(
      id: id,
      backdropUrl: backdropUrl,
      title: title,
      voteAverage: voteAverage,
      runtime: runtime,
      genres: genres,
      budget: budget,
      overview: overview,
      releaseDate:
        releaseDate
    )
  }
}
