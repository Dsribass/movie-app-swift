//
//  PathBuilder.swift
//  App
//
//  Created by Daniel de Souza Ribas on 23/05/22.
//

import Foundation

enum PathBuilder {
  static private let baseUrl = "https://desafio-mobile.nyc3.digitaloceanspaces.com"

  static private let movieSummaryListPath = "/movies"

  static func movieSummaryList() -> String {
    return "\(baseUrl)\(movieSummaryListPath)"
  }

  static func movie(_ id: Int) -> String {
    return "\(baseUrl)\(movieSummaryListPath)/\(id)"
  }
}
