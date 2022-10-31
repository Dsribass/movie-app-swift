//
//  MovieDetailRM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 07/06/22.
//

import Foundation

struct MovieDetailRM: Codable {
  let id: Int
  let backdropUrl: String
  let title: String
  let voteAverage: Double
  let runtime: Int
  let genres: [String]
  let releaseDate: Date
  let budget: Int
  let overview: String
}

extension MovieDetailRM {
  func toDM(isFavorite: Bool) -> MovieDetail {
    return MovieDetail(
      id: id,
      backdropUrl: backdropUrl,
      title: title,
      voteAverage: voteAverage,
      runtime: runtime,
      genres: genres,
      releaseDate: releaseDate,
      budget: budget,
      overview: overview,
      isFavorite: isFavorite)
  }
}
