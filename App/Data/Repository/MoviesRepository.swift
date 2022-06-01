//
//  MoviesRepository.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation

class MoviesRepository {
    init(movieRDS: MovieRemoteDataSource) {
        self.movieRDS = movieRDS
    }
    
    let movieRDS: MovieRemoteDataSource
    
    func getMovieSummaryList() async -> Result<[MovieSummary], AppError> {
        let result = await movieRDS.getMovieSummaryList()
        return result.map { movieSummaryRMList in
            movieSummaryRMList.toDM()
        }
    }
}
