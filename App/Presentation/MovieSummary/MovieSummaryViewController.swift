//
//  MovieSummaryViewController.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit

private typealias DataSource = UITableViewDiffableDataSource<Int, MovieSummary>
private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, MovieSummary>

class MovieSummaryViewController: UIViewController {
  init(presenter: MovieSummaryPresenter) {
    self.presenter = presenter
    super.init(
      nibName: String(describing: MovieSummaryViewController.self),
      bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var loadingSpinner: UIActivityIndicatorView!

  private let presenter: MovieSummaryPresenter
  private var errorView: ErrorView?
  private var movieSummaryList: [MovieSummary] = []

  private lazy var dataSource: DataSource = {
    DataSource(tableView: tableView) { tableView, _, movieSummary in
      let cell = tableView.dequeueReusableCell(
        withIdentifier: MovieSummaryTableViewCell.identifier
      ) as? MovieSummaryTableViewCell

      guard let cell = cell else {
        return MovieSummaryTableViewCell(
          movieSummary: movieSummary,
          style: .default,
          reuseIdentifier: MovieSummaryTableViewCell.identifier)
      }

      cell.setupCell(movieSummary: movieSummary)

      return cell
    }
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.attachView(view: self)
    setupTableView()
    fetchMovieSummaryList()
  }

  private func setupTableView() {
    tableView.register(
      MovieSummaryTableViewCell.getNib(),
      forCellReuseIdentifier: MovieSummaryTableViewCell.identifier)
    tableView.delegate = self
  }

  private func fetchMovieSummaryList() {
    Task.detached {
      await self.presenter.fetchMovieSummaryList()
    }
  }
}

extension MovieSummaryViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigationItem.backButtonTitle = ""
    navigationController?.navigationBar.tintColor = .red
    navigationController?.pushViewController(
      Factory.makeMovieDetailViewController(
        id: movieSummaryList[indexPath.row].id
      ),
      animated: true
    )
  }
}

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
    errorView.button.addAction(for: .touchUpInside) { _ in
      self.fetchMovieSummaryList()
    }

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

    var snapshot = Snapshot()
    snapshot.appendSections([0])
    snapshot.appendItems(success, toSection: 0)

    dataSource.apply(snapshot)
  }
}
