//
//  MovieSummaryVM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/05/22.
//

import Foundation

class MovieSummaryPresenter {
    var view: MovieSummaryViewController!
    
    func attachView(view: MovieSummaryViewController) {
            self.view = view
        }
    
    func fetchMovieSummaryList() async {
        await view.startLoading()
        
        // TODO(dani): inject dependencies
        let rds = MovieRemoteDataSource()
        let repository = MoviesRepository(movieRDS: rds)
        
        let result = await repository.getMovieSummaryList()
        
        switch(result) {
        case .success(let list):
            await view.stopLoading()
            await view.showSuccess(movieSummaryList: list)
        case .failure :
            await view.stopLoading()
            await view.showError()
        }
    }
}
