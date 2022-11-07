//
//  MovieDetailVM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 21/09/22.
//

import Foundation

struct MovieDetailVM {
  init(
    id: Int,
    backdropUrl: String,
    title: String,
    voteAverage: Double,
    runtime: Int,
    genres: [String],
    budget: Int,
    overview: String,
    releaseDate: Date,
    isFavorite: Bool = false
  ) {
    self.id = id
    self.backdropUrl = backdropUrl
    self.title = title
    self.voteAverage = voteAverage
    self.genres = genres
    self.overview = overview
    self.isFavorite = isFavorite
    self._budget = budget
    self._runtime = runtime
    self._releaseDate = releaseDate
  }

  let id: Int
  let backdropUrl: String
  let title: String
  let voteAverage: Double
  let genres: [String]
  let overview: String
  var isFavorite: Bool
  private let _budget: Int
  private let _runtime: Int
  private let _releaseDate: Date

  var releaseDate: String {
    return _releaseDate.formatted(date: .abbreviated, time: .omitted)
  }

  var runtime: String {
    let hour = _runtime / 60
    let minutes = _runtime % 60

    return "\(hour)h \(minutes)min"
  }

  var budget: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency

    return formatter.string(from: NSNumber(value: _budget)) ?? String(_budget)
  }
}