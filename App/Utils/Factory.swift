//
//  Factory.swift
//  App
//
//  Created by Daniel de Souza Ribas on 09/06/22.
//

import Foundation

class Factory {
    static private var appNetwork: AppNetwork?
    static private var movieRDS: MovieRemoteDataSource?
    static private var movieRepository: MoviesRepository?
    static private var movieSummaryPresenter: MovieSummaryPresenter?
    static private var movieDetailPresenter: MovieDetailPresenter?
}

/// Remote
extension Factory {
    static func makeAppNetwork() -> AppNetwork {
        if(appNetwork == nil) {
            appNetwork = AppNetwork()
        }
        return appNetwork!
        
    }
    
    static func makeMovieRemoteDataSource() -> MovieRemoteDataSource {
        if(movieRDS == nil) {
            movieRDS = MovieRemoteDataSource(appNetwork: makeAppNetwork())
        }
        return movieRDS!
    }
}

/// Repository
extension Factory {
    static func makeMovieRepository() -> MoviesRepository {
        if(movieRepository == nil) {
            movieRepository = MoviesRepository(movieRDS: makeMovieRemoteDataSource())
        }
        return movieRepository!
    }
}

/// Presenter
extension Factory {
    
    static func makeMovieSummaryPresenter() -> MovieSummaryPresenter {
        if(movieSummaryPresenter == nil) {
            movieSummaryPresenter = MovieSummaryPresenter(repository: makeMovieRepository())
        }
        return movieSummaryPresenter!
    }
    
    static func makeMovieDetailPresenter() -> MovieDetailPresenter {
        if(movieDetailPresenter == nil) {
            movieDetailPresenter = MovieDetailPresenter(repository: makeMovieRepository())
        }
        return movieDetailPresenter!
    }
}

/// View Controller
extension Factory {
    static func makeMovieSummaryViewController() -> MovieSummaryViewController {
        return MovieSummaryViewController(
            presenter: makeMovieSummaryPresenter()
        )
    }
    
    static func makeMovieDetailViewController(id: Int) -> MovieDetailViewController {
        return MovieDetailViewController(presenter: makeMovieDetailPresenter(), id: id)
    }
    
    static func makeFavoritesViewController() -> FavoritesViewController {
        return FavoritesViewController()
    }
}
