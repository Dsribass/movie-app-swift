//
//  MovieSummaryViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit
import RxSwift
import RxCocoa

class MovieSummaryViewController: ViewController {
  // MARK: - Initializers
  init(presenter: MovieSummaryPresenter) {
    self.presenter = presenter
    super.init(
      nibName: String(describing: MovieSummaryViewController.self),
      bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - IBOutlets
  @IBOutlet private weak var tableView: UITableView!

  // MARK: - Properties
  private let presenter: MovieSummaryPresenter
  var navigation: MovieNavigation?

  private lazy var movieSummaryList: [MovieSummary] = [] {
    didSet {
      var snapshot = Snapshot()
      snapshot.appendSections([0])
      snapshot.appendItems(movieSummaryList, toSection: 0)

      dataSource.apply(snapshot)
    }
  }

  private lazy var dataSource: DataSource = {
    DataSource(tableView: tableView) { tableView, _, movieSummary in
      let cell = tableView.dequeueReusableCell(
        withIdentifier: MovieSummaryTableViewCell.reuseIdentifer
      ) as? MovieSummaryTableViewCell

      guard let cell = cell else {
        return MovieSummaryTableViewCell(
          movieSummary: movieSummary,
          style: .default,
          reuseIdentifier: MovieSummaryTableViewCell.reuseIdentifer)
      }

      cell.setupCell(movieSummary: movieSummary)

      return cell
    }
  }()

  // MARK: - Subjects | Observables
  private let openMovieDetailSubject = PublishSubject<Int>()
  private var openMovieDetail: Observable<Int> { openMovieDetailSubject }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.attachView(view: self)
    setupObservables()
    setupTableView()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    navigationItem.title = "Filmes"
  }

  // MARK: - Methods
  private func setupTableView() {
    tableView.register(
      MovieSummaryTableViewCell.nib,
      forCellReuseIdentifier: MovieSummaryTableViewCell.reuseIdentifer)
  }

  private func setupObservables() {
    Observable.merge(Observable.just(()), onTryAgain)
      .bind { [unowned self] _ in
        self.presenter.fetchMovieSummaryList()
      }
      .disposed(by: bag)

    tableView.rx
      .itemSelected
      .map { [unowned self] indexPath in
        self.movieSummaryList[indexPath.row].id
      }
      .bind(to: openMovieDetailSubject)
      .disposed(by: bag)

    openMovieDetail
      .bind { [unowned self] id in
        self.navigation?.detailMovie(withId: id)
      }
      .disposed(by: bag)
  }
}

// MARK: - View State
extension MovieSummaryViewController: MovieSummaryViewState {
  func showMovieSummaryList(with list: [MovieSummary]) {
    self.movieSummaryList = list
  }
}

// MARK: - Protocols | Typealias
private typealias DataSource = UITableViewDiffableDataSource<Int, MovieSummary>
private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, MovieSummary>

protocol MovieSummaryViewState: ViewState {
  func showMovieSummaryList(with list: [MovieSummary])
}

protocol MovieNavigation: AnyObject {
  func detailMovie(withId id: Int)
}
