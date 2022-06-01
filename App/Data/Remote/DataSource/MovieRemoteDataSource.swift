//
//  MovieRemoteDataSource.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Foundation

class MovieRemoteDataSource {
    func getMovieSummaryList() async -> Result<[MovieSummaryRM], AppError> {
        let url = URL(string: PathBuilder.movieSummaryList())!
        
        let response = try? await URLSession.shared.data(from: url)
        let statusCode = (response?.1 as? HTTPURLResponse)?.statusCode
        
        if statusCode != 200 {
            return .failure(.requestError)
        }
        
        guard let data = response?.0 else {
            return .failure(.requestError)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .deferredToDate
        
        do {
            let movieSummaryList = try decoder.decode([MovieSummaryRM].self, from: data)
            return .success(movieSummaryList)
        } catch {
            return .failure(.decodingError)
        }
    }
}

