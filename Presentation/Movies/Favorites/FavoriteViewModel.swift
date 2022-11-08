//
//  FavoriteViewModel.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 07/11/22.
//

import Domain

public struct FavoriteMovieViewModel {
  private let movie: MovieSummary

  public init(movie: MovieSummary) {
    self.movie = movie
  }

  public var id: Int { movie.id }
  public var title: String { movie.title }
}
