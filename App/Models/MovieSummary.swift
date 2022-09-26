//
//  MovieSummary.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation

struct MovieSummary {
  let id: Int
  let title: String
  let posterUrl: String
  let releaseDate: Date
}

extension MovieSummary: Hashable {
  static func == (lhs: MovieSummary, rhs: MovieSummary) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
