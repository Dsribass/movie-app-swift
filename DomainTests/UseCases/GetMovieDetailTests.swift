//
//  GetMovieDetailTests.swift
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

class GetMovieDetailTests: XCTestCase {
  let scheduler = TestScheduler(initialClock: 0)
  var repository: MockMoviesDataRepository!
  var getMovieDetail: GetMovieDetail!

  let mockMovie: MovieDetail = .init(
    id: 1,
    backdropUrl: "url",
    title: "Movie Detail",
    voteAverage: 10.0,
    runtime: 120,
    genres: [],
    releaseDate: Date.now,
    budget: 1000,
    overview: "Overview")

  override func setUp() {
    repository = MockMoviesDataRepository()
    getMovieDetail = GetMovieDetail(repository: repository)
  }

  override func tearDown() {
    repository = nil
    getMovieDetail = nil
  }

  func test_getAllMovies_success() {
    stub(repository) { stub in
      when(stub.getMovieDetail(id: 1))
        .thenReturn(Single.just(mockMovie))
    }

    let sut = getMovieDetail.execute(with: GetMovieDetail.Request(id: 1)).toBlocking()

    XCTAssertEqual([try sut.first()], [mockMovie])
  }

  func test_getAllMovies_noConnectionError() {
    stub(repository) { stub in
      when(stub.getMovieDetail(id: 1))
        .thenReturn(Single.error(DomainError.noConnectivity))
    }

    let sut = scheduler.start { self.getMovieDetail.execute(with: GetMovieDetail.Request(id: 1)).asObservable() }

    let noConnectivityError = sut.events.map { event in
      event.value.error as? DomainError
    }

    XCTAssertEqual(noConnectivityError, [DomainError.noConnectivity])
  }

  func test_getAllMovies_genericError() {
    stub(repository) { stub in
      when(stub.getMovieDetail(id: 1))
        .thenReturn(Single.error(DomainError.unexpected(baseError: nil)))
    }

    let sut = scheduler.start { self.getMovieDetail.execute(with: GetMovieDetail.Request(id: 1)).asObservable() }

    let error = sut.events.map { event in
      event.value.error as? DomainError
    }

    XCTAssertEqual(error, [DomainError.unexpected(baseError: nil)])
  }
}

