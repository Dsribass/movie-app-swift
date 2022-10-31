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

// MARK: - Protocols
protocol MovieSummaryViewState: ViewState {
  func showMovieSummaryList(with list: [MovieSummary])
}

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
  private let movieSummaryListSubject = BehaviorSubject<[MovieSummary]>(value: [])
  private var movieSummaryList: Observable<[MovieSummary]> { movieSummaryListSubject }
  private var movieSummaryListValue: [MovieSummary] { (try? movieSummaryListSubject.value()) ?? [] }

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
    Observable.merge(Observable.just(()), onTryAgain)
      .bind { [unowned self] _ in
        presenter.fetchMovieSummaryList()
      }
      .disposed(by: bag)

    movieSummaryList
      .bind(to: tableView.rx
        .items(
          cellIdentifier: MovieSummaryTableViewCell.reuseIdentifer,
          cellType: MovieSummaryTableViewCell.self)
      ) { _, movieSummary, cell in
        cell.configure(with: movieSummary)
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
}

// MARK: - View State
extension MovieSummaryViewController: MovieSummaryViewState {
  func showMovieSummaryList(with list: [MovieSummary]) {
    movieSummaryListSubject.onNext(list)
  }
}
