//
//  MovieSummaryViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit
import RxSwift
import RxCocoa
import Swinject
import Domain

// MARK: - Protocols
protocol MovieNavigation: AnyObject {
  func detailMovie(withId id: Int)
}

// MARK: - View Controller
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

  // MARK: - Subjects | Observables
  private let movieSummaryListSubject = BehaviorSubject<[MovieSummaryViewModel]>(value: [])
  private var movieSummaryList: Observable<[MovieSummaryViewModel]> { movieSummaryListSubject }
  private var movieSummaryListValue: [MovieSummaryViewModel] {
    (try? movieSummaryListSubject.value()) ?? []
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupObservables()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let selectedIndexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: selectedIndexPath, animated: animated)
    }
  }

  // MARK: - Methods
  private func setupView() {
    navigationItem.title = "Filmes"

    tableView.register(
      MovieSummaryTableViewCell.nib,
      forCellReuseIdentifier: MovieSummaryTableViewCell.reuseIdentifer)
  }

  private func setupObservables() {
    listenViewState()

    movieSummaryList
      .bind(to: tableView.rx
        .items(
          cellIdentifier: MovieSummaryTableViewCell.reuseIdentifer,
          cellType: MovieSummaryTableViewCell.self)
      ) { _, movie, cell in
        cell.configure(with: movie)
      }
      .disposed(by: bag)

    tableView.rx
      .itemSelected
      .map { [unowned self] indexPath in
        movieSummaryListValue[indexPath.row].id
      }
      .bind { [unowned self] id in
        navigation?.detailMovie(withId: id)
      }
      .disposed(by: bag)
  }

  private func listenViewState() {
    Observable.merge(Observable.just(()), onTryAgain)
      .bind { [unowned self] _ in
        presenter.fetchMovieSummaryList()
      }
      .disposed(by: bag)

    presenter.states
      .bind { [unowned self] states in
        switch states {
        case .loading:
          startLoading()
        case .error(let error):
          stopLoading()
          showError(error: error)
        case .movies(let movies):
          stopLoading()
          showMovieSummaryList(with: movies)
        }
      }
      .disposed(by: bag)
  }
}

// MARK: - View State
extension MovieSummaryViewController: ViewState {
  func showMovieSummaryList(with list: [MovieSummaryViewModel]) {
    movieSummaryListSubject.onNext(list)
  }
}
