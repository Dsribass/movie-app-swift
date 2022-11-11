//
//  MovieDetailRM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 07/06/22.
//

import Foundation
import Domain

struct MovieDetailRM: Codable {
  let id: Int
  let backdropPath: String
  let title: String
  let voteAverage: Double
  let runtime: Int
  let genres: [MovieGenres]
  let releaseDate: Date
  let budget: Int
  let overview: String

  var backdropUrl: String { "https://image.tmdb.org/t/p/w500\(backdropPath)" }
}

struct MovieGenres: Codable {
  let id: Int
  let name: String
}

extension MovieDetailRM {
  func toDM(isFavorite: Bool) -> MovieDetail {
    return MovieDetail(
      id: id,
      backdropUrl: backdropUrl,
      title: title,
      voteAverage: voteAverage,
      runtime: runtime,
      genres: genres.map {$0.name},
      releaseDate: releaseDate,
      budget: budget,
      overview: overview,
      isFavorite: isFavorite)
  }
}
