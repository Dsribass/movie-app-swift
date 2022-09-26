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
    super.init(nibName: String(describing: "MovieSummaryViewController"), bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var loadingSpinner: UIActivityIndicatorView!

  private let errorView = ErrorView()
  private let presenter: MovieSummaryPresenter
  private var movieSummaryList: [MovieSummary] = []
  private var dataSource: DataSource!

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
    dataSource = createDataSource()
    tableView.delegate = self
  }

  private func createDataSource() -> DataSource {
    return DataSource(tableView: tableView) { tableView, _, movieSummary in
      let cell = tableView.dequeueReusableCell(
        withIdentifier: MovieSummaryTableViewCell.identifier
      ) as! MovieSummaryTableViewCell

      cell.setupCell(movieSummary: movieSummary)

      return cell
    }
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
    errorView.removeFromSuperview()
    loadingSpinner.isHidden = false
    tableView.isHidden = true
    loadingSpinner.startAnimating()
  }

  func stopLoading() {
    loadingSpinner.stopAnimating()
    loadingSpinner.isHidden = true
  }

  func showError() {
    loadingSpinner.isHidden = true
    tableView.isHidden = true
    setupErrorView()
  }

  private func setupErrorView() {
    errorView.translatesAutoresizingMaskIntoConstraints = false
    errorView.message.text = "Ocorreu um erro, tente novamente!"
    errorView.button.setTitle("Tente Novamente", for: .normal)
    errorView.button.addAction(for: .touchUpInside) { _ in
      self.fetchMovieSummaryList()
    }

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
