//
//  MovieDetailViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 01/06/22.
//

import UIKit
import RxSwift
import RxCocoa
import Swinject

// MARK: - Protocols | Typealias
protocol MovieDetailViewState: ViewState {
  func showMovieDetail(with movie: MovieDetailVM)
  func showUnfavoriteImage()
  func showFavoriteImage()
}

// MARK: - View Controller
class MovieDetailViewController: ViewController {
  // MARK: - Initializers
  init(presenter: MovieDetailPresenterActions, id: Int) {
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
  private let presenter: MovieDetailPresenterActions
  private let id: Int

  private var favoriteMovieImage: UIImage? {
    UIImage(systemName: "heart\(isFavoriteValue ? ".fill" : "")")
  }

  // MARK: - Subjects
  private let isFavoriteSubject = BehaviorSubject<Bool>(value: false)
  private var isFavorite: Observable<Bool> { isFavoriteSubject }
  private var isFavoriteValue: Bool { (try? isFavoriteSubject.value()) ?? false }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    setupObservables()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationItem.largeTitleDisplayMode = .always
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.largeTitleDisplayMode = .never
    onTryAgainSubject.onNext(())
  }

  // MARK: - Methods
  private func setupObservables() {
    Observable.merge(Observable.just(()), onTryAgain)
      .bind { [unowned self] _ in
        presenter.fetchMovieDetail(id: self.id)
      }
      .disposed(by: bag)

    navigationItem.rightBarButtonItem?.rx.tap
      .bind { [unowned self] _ in
        if isFavoriteValue {
          return presenter.unfavoriteMovie(with: id)
        }

        return presenter.favoriteMovie(with: id)
      }
      .disposed(by: bag)

    isFavorite
      .bind { [unowned self] _ in toggleFavoriteImage() }
      .disposed(by: bag)
  }

  private func setupLayout() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: favoriteMovieImage,
      style: .plain,
      target: self,
      action: .none)
    navigationItem.rightBarButtonItem?.isEnabled = false
  }

  private func toggleFavoriteImage() {
    navigationItem.rightBarButtonItem?.image = favoriteMovieImage
  }

  private func configure(with movieDetail: MovieDetailVM) {
    isFavoriteSubject.onNext(movieDetail.isFavorite)
    navigationItem.rightBarButtonItem?.isEnabled = true

    navigationItem.title = movieDetail.title
    rate.text = String(movieDetail.voteAverage)
    duration.text = movieDetail.runtime
    releaseDate.text = movieDetail.releaseDate
    budget.text = movieDetail.budget
    overview.text = movieDetail.overview
    movieImage.setImageFrom(
      url: movieDetail.backdropUrl,
      placeholderImage: UIImage(systemName: "film"))
  }
}

// MARK: - View State
extension MovieDetailViewController: MovieDetailViewState {
  func showUnfavoriteImage() { isFavoriteSubject.onNext(false) }

  func showFavoriteImage() { isFavoriteSubject.onNext(true) }

  func showMovieDetail(with movie: MovieDetailVM) { configure(with: movie) }
}