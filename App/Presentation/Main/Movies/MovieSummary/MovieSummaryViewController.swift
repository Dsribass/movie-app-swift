//
//  MovieSummaryViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit
import RxSwift
import RxCocoa

class MovieSummaryViewController: UIViewController {
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
  @IBOutlet private weak var loadingSpinner: UIActivityIndicatorView!

  // MARK: - Properties
  private let presenter: MovieSummaryPresenter
  private var errorView: ErrorView?
  private let bag = DisposeBag()
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

  private let onTryAgainSubject = PublishSubject<Void>()
  private var onTryAgain: Observable<Void> { onTryAgainSubject }

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
extension MovieSummaryViewController: ViewState {
  func startLoading() {
    errorView?.removeFromSuperview()
    loadingSpinner.isHidden = false
    tableView.isHidden = true
    loadingSpinner.startAnimating()
  }

  func stopLoading() {
    loadingSpinner.stopAnimating()
    loadingSpinner.isHidden = true
  }

  func showError(error: AppError) {
    loadingSpinner.isHidden = true
    tableView.isHidden = true

    let errorView = ErrorView(error: error, frame: .zero)
    errorView.translatesAutoresizingMaskIntoConstraints = false
    errorView.button.rx
      .tap
      .bind(to: onTryAgainSubject)
      .disposed(by: bag)

    self.errorView = errorView
    view.addSubview(errorView)

    NSLayoutConstraint.activate([
      errorView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: errorView.trailingAnchor, multiplier: 2),
      errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  func showSuccess(success: [MovieSummary]) {
    self.movieSummaryList = success
    tableView.isHidden = false
  }
}

// MARK: - Protocols | Typealias
private typealias DataSource = UITableViewDiffableDataSource<Int, MovieSummary>
private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, MovieSummary>

protocol MovieNavigation: AnyObject {
  func detailMovie(withId id: Int)
}
