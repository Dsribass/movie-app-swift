//
//  MovieSummaryViewModel.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 07/11/22.
//

import Domain
import Foundation

struct MovieSummaryViewModel {
  init(movie: MovieSummary) {
    self.movie = movie
  }

  private let movie: MovieSummary

  var id: Int { movie.id }
  var title: String { movie.title }
  var releaseDate: String { movie.releaseDate.formatted(date: .long, time: .omitted) }
  var imageUrl: String { movie.posterUrl }
}
