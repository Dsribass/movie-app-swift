//
//  MovieDetailViewModel.swift
//  App
//
//  Created by Daniel de Souza Ribas on 21/09/22.
//

import Foundation
import Domain

public struct MovieDetailViewModel {
  private let movieDetail: MovieDetail

  public init(movieDetail: MovieDetail) {
    self.movieDetail = movieDetail
  }

  public var id: Int { movieDetail.id }
  public var backdropUrl: String { movieDetail.backdropUrl }
  public var title: String { movieDetail.title }
  public var voteAverage: String { "\(movieDetail.voteAverage.round(to: 1))" }
  public var genres: [String] { movieDetail.genres }
  public var overview: String { movieDetail.overview.isEmpty ? "..." : movieDetail.overview }
  public var isFavorite: Bool { movieDetail.isFavorite }

  public var releaseDate: String {
    return movieDetail.releaseDate.formatted(date: .abbreviated, time: .omitted)
  }

  public var runtime: String {
    let hour = movieDetail.runtime / 60
    let minutes = movieDetail.runtime % 60

    return "\(hour)h \(minutes)min"
  }

  public var budget: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency

    return formatter.string(
      from: NSNumber(value: movieDetail.budget)
    ) ?? String(movieDetail.budget)
  }
}
