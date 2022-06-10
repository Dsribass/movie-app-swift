//
//  MovieSummaryViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit

class MovieSummaryViewController: UIViewController {
    init(presenter: MovieSummaryPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: "MovieSummaryViewController"), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let presenter: MovieSummaryPresenter
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var movieSummaryTableView: UITableView!
    var movieSummaryList: [MovieSummary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        setupTableView()
        Task.detached() {
            await self.presenter.fetchMovieSummaryList()
        }
    }
    
    private func setupTableView() {
        movieSummaryTableView.delegate = self
        movieSummaryTableView.dataSource = self
        movieSummaryTableView.register(MovieSummaryTableViewCell.getNib(), forCellReuseIdentifier: MovieSummaryTableViewCell.identifier)
    }
}

extension MovieSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSummaryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieSummaryTableViewCell.identifier,
            for: indexPath
        ) as! MovieSummaryTableViewCell
        
        cell.setupCell(movieSummary: movieSummaryList[indexPath.row])
        
        return cell
    }
}

extension MovieSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .red
        navigationController?.pushViewController(MovieDetailViewController(), animated: true)
    }
}

extension MovieSummaryViewController: MovieSummaryStates {    
    func startLoading() {
        loadingSpinner.isHidden = false
        movieSummaryTableView.isHidden = true
        loadingSpinner.startAnimating()
    }
    
    func stopLoading() {
        loadingSpinner.stopAnimating()
        loadingSpinner.isHidden = true
    }
    
    func showError() {
    }
    
    func showSuccess(movieSummaryList: [MovieSummary]) {
        self.movieSummaryList = movieSummaryList
        movieSummaryTableView.isHidden = false
        movieSummaryTableView.reloadData()
    }
}
