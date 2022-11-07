//
//  MovieSummaryViewModel.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 07/11/22.
//

import Domain
import Foundation

public struct MovieSummaryViewModel {
  public init(movie: MovieSummary) {
    self.movie = movie
  }

  private let movie: MovieSummary

  public var id: Int { movie.id }
  public var title: String { movie.title }
  public var releaseDate: String { movie.releaseDate.formatted(date: .long, time: .omitted) }
  public var imageUrl: String { movie.posterUrl }
}
