//
//  MovieSummaryRM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation
import Domain

struct MovieSummaryRM: Codable {
  let id: Int
  let voteAverage: Double
  let title: String
  let posterUrl: String
  let genres: [String]
  let releaseDate: Date
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
