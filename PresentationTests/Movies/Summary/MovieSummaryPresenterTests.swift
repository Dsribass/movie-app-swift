//
//  MovieSummaryPresenterTests.swift
//  PresentationTests
//
//  Created by Daniel de Souza Ribas on 09/11/22.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
import Cuckoo
import Domain
@testable import Presentation


final class MovieSummaryPresenterTests: XCTestCase {
  let scheduler = TestScheduler(initialClock: 0)
  let bag = DisposeBag()
  var getMovieSummaryList: MockGetMovieSummaryListUseCase!
  var presenter: MovieSummaryPresenter!

  let mockMovies: [MovieSummary] = [
    .init(id: 1, title: "Movie 1", posterUrl: "URL", releaseDate: Date.now),
    .init(id: 2, title: "Movie 2", posterUrl: "URL", releaseDate: Date.now),
  ]

  var mockMovieViewModelList: [MovieSummaryViewModel] { mockMovies.map {MovieSummaryViewModel(movie: $0)} }

  override func setUp() {
    getMovieSummaryList = MockGetMovieSummaryListUseCase()
    presenter = MovieSummaryPresenter(getMovieSummaryList: getMovieSummaryList)
  }

  func testMovieSummaryStatesSuccess() {
    stub(getMovieSummaryList) {
      when($0.execute(with: any())).thenReturn(Single.just(mockMovies))
    }

    let observer = scheduler.createObserver(MovieSummaryPresenter.States.self)
    presenter.states.subscribe(observer).disposed(by: bag)
    presenter.fetchMovieSummaryList()

    guard let result = observer.events.last else {
      XCTFail()
      return
    }

    XCTAssertRecordedElements([result], [.movies(mockMovieViewModelList)])
  }

  func testMovieSummaryStatesLoading() {
    stub(getMovieSummaryList) {
      when($0.execute(with: any())).thenReturn(Single.just(mockMovies))
    }

    let observer = scheduler.createObserver(MovieSummaryPresenter.States.self)
    presenter.states.subscribe(observer).disposed(by: bag)
    presenter.fetchMovieSummaryList()

    guard let result = observer.events.first else {
      XCTFail()
      return
    }

    XCTAssertRecordedElements([result], [.loading])
  }

  func testMovieSummaryStatesError() {
    stub(getMovieSummaryList) {
      when($0.execute(with: any()))
        .thenReturn(Single.error(DomainError.noConnectivity))
    }

    let observer = scheduler.createObserver(MovieSummaryPresenter.States.self)
    presenter.states.subscribe(observer).disposed(by: bag)
    presenter.fetchMovieSummaryList()

    guard let result = observer.events.last else {
      XCTFail()
      return
    }

    XCTAssertRecordedElements([result], [.error(.noConnectivity)])
  }
}

extension MovieSummaryPresenter.States: Equatable {
  public static func == (lhs: Presentation.MovieSummaryPresenter.States, rhs: Presentation.MovieSummaryPresenter.States) -> Bool {
    switch (lhs, rhs) {
    case (.loading, .loading): return true
    case (.error(_), .error(_)): return true
    case (.movies(_), .movies(_)): return true
    default: return false
    }
  }
}
