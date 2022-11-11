//
//  MovieSummaryRM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation
import Domain

struct MovieSummaryDataRM: Codable {
  let results: [MovieSummaryRM]
}

struct MovieSummaryRM: Codable, Equatable {
  let id: Int
  let title: String
  let posterPath: String
  let releaseDate: Date

  var posterUrl: String {
    "https://image.tmdb.org/t/p/w500\(posterPath)"
  }
}

extension Array where Element == MovieSummaryRM {
  func toDM() -> [MovieSummary] {
    map { MovieSummary(
      id: $0.id,
      title: $0.title,
      posterUrl: $0.posterUrl,
      releaseDate: $0.releaseDate)
    }
  }
}
