//
//  MovieSummaryVM.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/05/22.
//

import Foundation

class MovieSummaryPresenter {
    init(repository : MoviesRepository) {
        self.repository = repository
    }

    let repository : MoviesRepository
    
    var view: MovieSummaryViewController!
    
    func attachView(view: MovieSummaryViewController) {
            self.view = view
        }
    
    func fetchMovieSummaryList() async {
        await view.startLoading()

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
