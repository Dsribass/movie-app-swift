//
//  GetFavoriteMoviesTests.swift
//  DomainTests
//
//  Created by Daniel de Souza Ribas on 08/11/22.
//

import XCTest
import Cuckoo
import RxSwift
import RxBlocking
import RxTest
@testable import Domain

class GetFavoriteMoviesTests: XCTestCase {
  let scheduler = TestScheduler(initialClock: 0)
  var repository: MockMoviesDataRepository!
  var getFavoriteMovies: GetFavoriteMovies!

  let mockMovies: [MovieSummary] = [
    .init(id: 1, title: "Movie 1", posterUrl: "URL", releaseDate: Date.now),
    .init(id: 2, title: "Movie 2", posterUrl: "URL", releaseDate: Date.now)
  ]

  override func setUp() {
    repository = MockMoviesDataRepository()
    getFavoriteMovies = GetFavoriteMovies(repository: repository)
  }

  override func tearDown() {
    repository = nil
    getFavoriteMovies = nil
  }

  func test_getFavoriteMovies_success() {
    stub(repository) { stub in
      when(stub.getMovieSummaryList(onlyFavoriteMovies: true))
        .thenReturn(Single.just(mockMovies))
    }

    let sut = getFavoriteMovies.execute(with: ()).toBlocking()

    XCTAssertEqual([try sut.first()], [mockMovies])
  }

  func test_getFavoriteMovies_noConnectionError() {
    stub(repository) { stub in
      when(stub.getMovieSummaryList(onlyFavoriteMovies: true))
        .thenReturn(Single.error(DomainError.noConnectivity))
    }

    let sut = scheduler.start { self.getFavoriteMovies.execute(with: ()).asObservable() }

    let noConnectivityError = sut.events.map { event in
      event.value.error as? DomainError
    }

    XCTAssertEqual(noConnectivityError, [DomainError.noConnectivity])
  }

  func test_getFavoriteMovies_genericError() {
    stub(repository) { stub in
      when(stub.getMovieSummaryList(onlyFavoriteMovies: true))
        .thenReturn(Single.error(DomainError.unexpected(baseError: nil)))
    }

    let sut = scheduler.start { self.getFavoriteMovies.execute(with: ()).asObservable() }

    let error = sut.events.map { event in
      event.value.error as? DomainError
    }

    XCTAssertEqual(error, [DomainError.unexpected(baseError: nil)])
  }
}
