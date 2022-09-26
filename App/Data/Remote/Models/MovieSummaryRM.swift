//
//  MovieSummaryRM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation

struct MovieSummaryRM : Codable {
  let id: Int
  let voteAverage: Double
  let title: String
  let posterUrl: String
  let genres: [String]
  let releaseDate: Date
}
