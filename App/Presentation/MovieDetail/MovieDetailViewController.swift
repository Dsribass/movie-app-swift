//
//  MovieDetailViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 01/06/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    init(presenter: MovieDetailPresenter, id: Int) {
        self.presenter = presenter
        self.id = id
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let presenter: MovieDetailPresenter
    let id: Int

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        Task.detached() {
            await self.presenter.fetchMovieDetail(id: self.id)
        }
    }

}


extension MovieDetailViewController: MovieDetailStates {
    func startLoading() {
        loadingSpinner.isHidden = false
        contentView.isHidden = true
        loadingSpinner.startAnimating()
    }
    
    func stopLoading() {
        loadingSpinner.stopAnimating()
        loadingSpinner.isHidden = true
    }
    
    func showError() {
        loadingSpinner.isHidden = true
        contentView.isHidden = true
        setupErrorView()
    }
    
    private func setupErrorView() {
        let errorView = ErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.message.text = "Ocorreu um erro, tente novamente!"
        errorView.button.setTitle("Tente Novamente", for: .normal)
        
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: errorView.trailingAnchor, multiplier: 2),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    fileprivate func setupViewWith(movieDetail: MovieDetail) {
        if let url = URL(string: movieDetail.backdropUrl) {
            UIImage.loadFrom(url: url) { image in
                if let image = image {
                    self.movieImage.image = image
                }
            }
        }
        
        movieTitle.text = movieDetail.title
        rate.text = String(movieDetail.voteAverage)
        duration.text = String(movieDetail.runtime)
        releaseDate.text = movieDetail.releaseDate
        budget.text = String(movieDetail.budget)
        overview.text = movieDetail.overview
    }
    
    func showSuccess(movieDetail: MovieDetail) {
        contentView.isHidden = false
        setupViewWith(movieDetail: movieDetail)
    }
}
