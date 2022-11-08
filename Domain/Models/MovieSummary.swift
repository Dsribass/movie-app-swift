//
//  MovieSummary.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation

public struct MovieSummary {
  public init(id: Int, title: String, posterUrl: String, releaseDate: Date) {
    self.id = id
    self.title = title
    self.posterUrl = posterUrl
    self.releaseDate = releaseDate
  }

  public let id: Int
  public let title: String
  public let posterUrl: String
  public let releaseDate: Date
}

extension MovieSummary: Hashable {
  public static func == (lhs: MovieSummary, rhs: MovieSummary) -> Bool {
    return lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
