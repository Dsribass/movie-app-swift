//
//  FavoriteViewModel.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 07/11/22.
//

import Domain

struct FavoriteMovieViewModel {
  private let movie: MovieSummary

  init(movie: MovieSummary) {
    self.movie = movie
  }

  var id: Int { movie.id }
  var title: String { movie.title }
}
