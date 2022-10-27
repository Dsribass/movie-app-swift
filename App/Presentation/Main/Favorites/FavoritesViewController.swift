//
//  FavoritesViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Protocols
private typealias DataSource = UITableViewDiffableDataSource<Int, MovieSummary>
private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, MovieSummary>
protocol FavoritesViewState: ViewState {
  func showFavoriteMovies(with movieSummaryList: [MovieSummary])
  func removeFavoriteMovieFromTableView(with id: Int)
}

// MARK: - View Controller
class FavoritesViewController: ViewController {
  // MARK: - Initializers
  init(presenter: FavoritesPresenter) {
    self.presenter = presenter
    super.init(nibName: String(describing: FavoritesViewController.self), bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!

  // MARK: - Properties
  private let presenter: FavoritesPresenter
  private let cellReuseIdentifier = "FavoriteMovieCell"
  private lazy var dataSource: DataSource = {
    DataSource(tableView: tableView) { [unowned self] tableView, _, movieSummary in
      let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) ?? UITableViewCell()

      var content = cell.defaultContentConfiguration()
      content.text = movieSummary.title
      content.textProperties.font = UIFont.preferredFont(forTextStyle: .title3)

      cell.contentConfiguration = content
      return cell
    }
  }()

  // MARK: - Subjects
  private let onUnfavoriteMovieSubject = PublishSubject<Int>()
  private var onUnfavoriteMovie: Observable<Int> { onUnfavoriteMovieSubject }

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
    tableView.dataSource = dataSource
    tableView.delegate = self
  }

  private func setupObservables() {
    Observable.merge(Observable.just(()), onTryAgain)
      .bind { [unowned self] _ in
        presenter.fetchFavoriteMovies()
      }
      .disposed(by: bag)

    onUnfavoriteMovie
      .bind { [unowned self] id in
        presenter.unfavoriteMovie(with: id)
      }
      .disposed(by: bag)

    movieSummaryList
      .bind { [unowned self] movies in updateTable(list: movies) }
      .disposed(by: bag)
  }

  func updateTable(list: [MovieSummary]) {
    var snapshot = Snapshot()
    snapshot.appendSections([0])
    snapshot.appendItems(list, toSection: 0)

    dataSource.apply(snapshot)
  }
}

// MARK: - Table View Delegate
extension FavoritesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "Desfavoritar") { [unowned self] _, _, handler in
      let movieId = movieSummaryListValue[indexPath.row].id
      onUnfavoriteMovieSubject.onNext(movieId)
      return handler(true)
    }

    let config = UISwipeActionsConfiguration(actions: [deleteAction])
    config.performsFirstActionWithFullSwipe = false
    return config
  }
}

// MARK: - View State
extension FavoritesViewController: FavoritesViewState {
  func showFavoriteMovies(with movieSummaryList: [MovieSummary]) {
    movieSummaryListSubject.onNext(movieSummaryList)
  }

  func removeFavoriteMovieFromTableView(with id: Int) {
    var currentFavoriteMovies = movieSummaryListValue
    currentFavoriteMovies.removeAll { $0.id == id }

    movieSummaryListSubject.onNext(currentFavoriteMovies)
  }
}
