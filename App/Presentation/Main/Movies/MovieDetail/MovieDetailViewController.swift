//
//  MovieDetailViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 01/06/22.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailViewController: UIViewController {
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
  @IBOutlet private weak var loadingSpinner: UIActivityIndicatorView!
  @IBOutlet private weak var rate: UILabel!
  @IBOutlet private weak var duration: UILabel!
  @IBOutlet private weak var releaseDate: UILabel!
  @IBOutlet private weak var budget: UILabel!
  @IBOutlet private weak var overview: UILabel!

  // MARK: - Properties
  private let presenter: MovieDetailPresenter
  private let id: Int
  private var errorView: ErrorView?
  private let bag = DisposeBag()

  // MARK: - Subjects | Observables
  private let onTryAgainSubject = PublishSubject<Void>()
  private var onTryAgain: Observable<Void> { onTryAgainSubject }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.attachView(view: self)
    presenter.fetchMovieDetail(id: id)
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
}

// MARK: - View State
extension MovieDetailViewController: ViewState {
  func startLoading() {
    errorView?.removeFromSuperview()
    loadingSpinner.isHidden = false
    contentView.isHidden = true
    loadingSpinner.startAnimating()
  }

  func stopLoading() {
    loadingSpinner.stopAnimating()
    loadingSpinner.isHidden = true
  }

  func showError(error: AppError) {
    loadingSpinner.isHidden = true
    contentView.isHidden = true

    let errorView = ErrorView(error: error, frame: .zero)
    errorView.translatesAutoresizingMaskIntoConstraints = false
    errorView.button.rx
      .tap
      .bind(to: onTryAgainSubject)
      .disposed(by: bag)

    view.addSubview(errorView)
    self.errorView = errorView

    NSLayoutConstraint.activate([
      errorView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: errorView.trailingAnchor, multiplier: 2),
      errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  func showSuccess(success: MovieDetailVM) {
    contentView.isHidden = false
    setupViewWith(movieDetail: success)
  }

  private func setupViewWith(movieDetail: MovieDetailVM) {
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
