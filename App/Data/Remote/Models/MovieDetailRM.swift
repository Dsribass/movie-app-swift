//
//  MovieDetailRM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 07/06/22.
//

import Foundation

struct MovieDetailRM: Codable{
    let id: Int
    let backdropUrl: String
    let title: String
    let voteAverage: Double
    let runtime: Int
    let genres: [String]
    let releaseDate: Date
    let budget: Int
    let overview: String
}
