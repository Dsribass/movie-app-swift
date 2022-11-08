//
//  GetMovieSummaryListTests.swift
//  DomainTests
//
//  Created by Daniel de Souza Ribas on 07/11/22.
//

import XCTest
import Cuckoo
import RxSwift
import RxBlocking
import RxTest
@testable import Domain

class GetMovieSummaryListTests: XCTestCase {
  let scheduler = TestScheduler(initialClock: 0)
  let bag = DisposeBag()
  var repository: MockMoviesDataRepository!
  var getMovieSummaryList: GetMovieSummaryList!

  let mockMovies: [MovieSummary] = [
    .init(id: 1, title: "Movie 1", posterUrl: "URL", releaseDate: Date.now),
    .init(id: 2, title: "Movie 2", posterUrl: "URL", releaseDate: Date.now)
  ]

  override func setUp() {
    repository = MockMoviesDataRepository()
    getMovieSummaryList = GetMovieSummaryList(repository: repository)
  }

  override func tearDown() {
    repository = nil
    getMovieSummaryList = nil
  }

  func test_getAllMovies_success() {
    stub(repository) { stub in
      when(stub.getMovieSummaryList(onlyFavoriteMovies: false))
        .thenReturn(Single.just(mockMovies))
    }

    let sut = getMovieSummaryList.execute(with: ()).toBlocking()

    XCTAssertEqual([try sut.first()], [mockMovies])
  }

  func test_getAllMovies_noConnectionError() {
    stub(repository) { stub in
      when(stub.getMovieSummaryList(onlyFavoriteMovies: false))
        .thenReturn(Single.error(DomainError.noConnectivity))
    }

    let sut = scheduler.start { self.getMovieSummaryList.execute(with: ()).asObservable() }

    let noConnectivityError = sut.events.map { event in
      event.value.error as? DomainError
    }

    XCTAssertEqual(noConnectivityError, [DomainError.noConnectivity])
  }

  func test_getAllMovies_genericError() {
    stub(repository) { stub in
      when(stub.getMovieSummaryList(onlyFavoriteMovies: false))
        .thenReturn(Single.error(DomainError.unexpected(baseError: nil)))
    }

    let sut = scheduler.start { self.getMovieSummaryList.execute(with: ()).asObservable() }

    let error = sut.events.map { event in
      event.value.error as? DomainError
    }

    XCTAssertEqual(error, [DomainError.unexpected(baseError: nil)])
  }
}
