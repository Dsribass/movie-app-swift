//
//  MovieDetailRM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 07/06/22.
//

import Foundation

public struct MovieDetail: Equatable {
  public init(
    id: Int,
    backdropUrl: String,
    title: String,
    voteAverage: Double,
    runtime: Int,
    genres: [String],
    releaseDate: Date,
    budget: Int,
    overview: String,
    isFavorite: Bool = false
  ) {
    self.id = id
    self.backdropUrl = backdropUrl
    self.title = title
    self.voteAverage = voteAverage
    self.runtime = runtime
    self.genres = genres
    self.releaseDate = releaseDate
    self.budget = budget
    self.overview = overview
    self.isFavorite = isFavorite
  }

  public let id: Int
  public let backdropUrl: String
  public let title: String
  public let voteAverage: Double
  public let runtime: Int
  public let genres: [String]
  public let releaseDate: Date
  public let budget: Int
  public let overview: String
  public var isFavorite = false
}
