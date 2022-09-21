//
//  MovieRemoteDataSource.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation

class MovieRemoteDataSource {
    init(appNetwork: AppNetwork) {
        self.appNetwork = appNetwork
    }
    
    let appNetwork: AppNetwork
    
    func getMovieSummaryList() async -> Result<[MovieSummaryRM], AppError> {
        return await appNetwork.request(
            urlString: PathBuilder.movieSummaryList(),
            decoder: getJSONDecoder()
        ) as Result<[MovieSummaryRM], AppError>
    }
    
    func getMovieDetail(id: Int) async -> Result<MovieDetailRM, AppError> {
        return await appNetwork.request(
            urlString: PathBuilder.movie(id),
            decoder: getJSONDecoder()
        ) as Result<MovieDetailRM, AppError>
    }
    
    private func getJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        return decoder

    }
}

