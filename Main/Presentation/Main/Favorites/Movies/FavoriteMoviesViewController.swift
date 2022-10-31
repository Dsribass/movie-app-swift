//
//  FavoritesViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

// MARK: - Protocols
protocol FavoritesViewState: ViewState {
  func showFavoriteMovies(with movieSummaryList: [MovieSummary])
  func removeFavoriteMovieFromTableView(with id: Int)
}

// MARK: - View Controller
class FavoriteMoviesViewController: ViewController {
  // MARK: - Initializers
  init(presenter: FavoriteMoviesPresenter) {
    self.presenter = presenter
    super.init(nibName: String(describing: FavoriteMoviesViewController.self), bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!

  // MARK: - Properties
  private let presenter: FavoriteMoviesPresenter
  private let cellReuseIdentifier = "FavoriteMovieCell"

  // MARK: - Subjects
  private let movieSummaryListSubject = BehaviorSubject<[MovieSummary]>(value: [])
  private var movieSummaryList: Observable<[MovieSummary]> { movieSummaryListSubject }
  private var movieSummaryListValue: [MovieSummary] { (try? movieSummaryListSubject.value()) ?? [] }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.attachView(self)
    setupView()
    setupObservables()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    onTryAgainSubject.onNext(())
  }

  // MARK: - Methods
  private func setupView() {
    navigationItem.title = "Favoritos"

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
  }

  private func setupObservables() {
    Observable.merge(Observable.just(()), onTryAgain)
      .bind { [unowned self] _ in
        presenter.fetchFavoriteMovies()
      }
      .disposed(by: bag)

    movieSummaryList
      .bind(to: tableView.rx
        .items(
          cellIdentifier: cellReuseIdentifier,
          cellType: UITableViewCell.self)
      ) { _, element, cell in
        var content = cell.defaultContentConfiguration()
        content.text = element.title
        content.textProperties.font = UIFont.preferredFont(forTextStyle: .title3)

        cell.contentConfiguration = content
      }
      .disposed(by: bag)

    tableView.rx
      .itemDeleted
      .map { [unowned self] indexPath in movieSummaryListValue[indexPath.row].id }
      .bind { [unowned self] id in
        presenter.unfavoriteMovie(with: id)
      }
      .disposed(by: bag)
  }
}

// MARK: - View State
extension FavoriteMoviesViewController: FavoritesViewState {
  func showFavoriteMovies(with movieSummaryList: [MovieSummary]) {
    movieSummaryListSubject.onNext(movieSummaryList)
  }

  func removeFavoriteMovieFromTableView(with id: Int) {
    var currentFavoriteMovies = movieSummaryListValue
    currentFavoriteMovies.removeAll { $0.id == id }

    movieSummaryListSubject.onNext(currentFavoriteMovies)
  }
}
