//
//  Factory.swift
//  App
//
//  Created by Daniel de Souza Ribas on 09/06/22.
//

import Foundation

class Factory {
    var appNetwork: AppNetwork?
    var movieRDS: MovieRemoteDataSource?
    var movieRepository: MoviesRepository?
    var movieSummaryPresenter: MovieSummaryPresenter?
    var movieSummaryViewController: MovieSummaryViewController?
    
    func makeAppNetwork() -> AppNetwork {
        return appNetwork ?? AppNetwork()
    }
    
    func makeMovieRemoteDataSource() -> MovieRemoteDataSource {
        return movieRDS ?? MovieRemoteDataSource(appNetwork: makeAppNetwork())
    }
    
    func makeMovieRepository() -> MoviesRepository {
        return movieRepository ?? MoviesRepository(movieRDS: makeMovieRemoteDataSource())
    }
    
    func makeMovieSummaryPresenter() -> MovieSummaryPresenter {
        return movieSummaryPresenter ?? MovieSummaryPresenter(repository: makeMovieRepository())
    }
    
    func makeMovieSummaryViewController() -> MovieSummaryViewController {
        if movieSummaryViewController != nil {
            return movieSummaryViewController!
        }
        
        movieSummaryViewController = MovieSummaryViewController(presenter: makeMovieSummaryPresenter())
        return movieSummaryViewController!
    }
}
