//
//  MovieDetailViewModel.swift
//  App
//
//  Created by Daniel de Souza Ribas on 21/09/22.
//

import Foundation
import Domain

struct MovieDetailViewModel {
  private let movieDetail: MovieDetail

  init(movieDetail: MovieDetail) {
    self.movieDetail = movieDetail
  }

  var id: Int { movieDetail.id }
  var backdropUrl: String { movieDetail.backdropUrl }
  var title: String { movieDetail.title }
  var voteAverage: Double { movieDetail.voteAverage }
  var genres: [String] { movieDetail.genres }
  var overview: String { movieDetail.overview }
  var isFavorite: Bool { movieDetail.isFavorite }

  var releaseDate: String {
    return movieDetail.releaseDate.formatted(date: .abbreviated, time: .omitted)
  }

  var runtime: String {
    let hour = movieDetail.runtime / 60
    let minutes = movieDetail.runtime % 60

    return "\(hour)h \(minutes)min"
  }

  var budget: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency

    return formatter.string(
      from: NSNumber(value: movieDetail.budget)
    ) ?? String(movieDetail.budget)
  }
}
