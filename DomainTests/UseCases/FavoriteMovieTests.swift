//
//  FavoriteMovieTests.swift
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

class FavoriteMovieTests: XCTestCase {
  let scheduler = TestScheduler(initialClock: 0)
  var repository: MockMoviesDataRepository!
  var favoriteMovie: FavoriteMovie!

  override func setUp() {
    repository = MockMoviesDataRepository()
    favoriteMovie = FavoriteMovie(repository: repository)
  }

  override func tearDown() {
    repository = nil
    favoriteMovie = nil
  }

  func test_favoriteMovie_success() {
    stub(repository) { stub in
      when(stub.favoriteMovie(with: any()))
        .thenReturn(Completable.empty())
    }

    let sut = scheduler.start {
      self.favoriteMovie.execute(with: FavoriteMovie.Request(id: 1)).asObservable()
    }

    XCTAssertEqual(sut.events, [.completed(200)])
  }

  func test_favoriteMovie_genericError() {
    stub(repository) { stub in
      when(stub.favoriteMovie(with: any()))
        .thenReturn(Completable.error(DomainError.unexpected(baseError: nil)))
    }

    let sut = scheduler.start {
      self.favoriteMovie.execute(with: FavoriteMovie.Request(id: 1)).asObservable()
    }

    let error = sut.events.map { event in
      event.value.error as? DomainError
    }

    XCTAssertEqual(error, [DomainError.unexpected(baseError: nil)])
  }
}
