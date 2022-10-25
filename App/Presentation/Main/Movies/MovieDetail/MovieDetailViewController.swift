//
//  MovieDetailViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 01/06/22.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Protocols | Typealias
protocol MovieDetailViewState: ViewState {
  func showMovieDetail(with movie: MovieDetailVM)
}

// MARK: - View Controller
class MovieDetailViewController: ViewController {
  // MARK: - Initializers
  init(presenter: MovieDetailPresenter, id: Int) {
    self.presenter = presenter
    self.id = id
    super.init(
      nibName: String(describing: MovieDetailViewController.self),
      bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - IBOutlets
  @IBOutlet private weak var contentView: UIView!
  @IBOutlet private weak var movieImage: UIImageView!
  @IBOutlet private weak var rate: UILabel!
  @IBOutlet private weak var duration: UILabel!
  @IBOutlet private weak var releaseDate: UILabel!
  @IBOutlet private weak var budget: UILabel!
  @IBOutlet private weak var overview: UILabel!

  // MARK: - Properties
  private let presenter: MovieDetailPresenter
  private let id: Int

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.attachView(view: self)
    setupObservables()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationItem.largeTitleDisplayMode = .always
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.largeTitleDisplayMode = .never
  }

  // MARK: - Methods
  private func setupObservables() {
    Observable.merge(Observable.just(()), onTryAgain)
      .bind { [unowned self] _ in
        self.presenter.fetchMovieDetail(id: self.id)
      }
      .disposed(by: bag)
  }

  private func configure(with movieDetail: MovieDetailVM) {
    if let url = URL(string: movieDetail.backdropUrl) {
      self.movieImage.kf.setImage(
        with: url,
        placeholder: UIImage(systemName: "film"))
    }

    navigationItem.title = movieDetail.title
    rate.text = String(movieDetail.voteAverage)
    duration.text = movieDetail.runtime
    releaseDate.text = movieDetail.releaseDate
    budget.text = movieDetail.budget
    overview.text = movieDetail.overview
  }
}

// MARK: - View State
extension MovieDetailViewController: MovieDetailViewState {
  func showMovieDetail(with movie: MovieDetailVM) { configure(with: movie) }
}
