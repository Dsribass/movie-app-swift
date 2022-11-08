//
//  MovieRepositoryTests.swift
//  DataTests
//
//  Created by Daniel de Souza Ribas on 08/11/22.
//

import XCTest
import Cuckoo
import RxSwift
import RxBlocking
import RxTest
import Moya
import Domain
@testable import Data

final class MovieRepositoryTests: XCTestCase {
  let scheduler = TestScheduler(initialClock: 0)

  var movieRDS: MockMovieRemoteDataSource!
  var userPreferencesCDS: MockUserPreferencesCacheDataSource!
  var repository: MoviesRepository!

  let mockMoviesRM: [MovieSummaryRM] = [
    .init(id: 1, voteAverage: 1.0, title: "Movie 1", posterUrl: "URL", genres: [], releaseDate: Date.now),
    .init(id: 2, voteAverage: 2.0, title: "Movie 2", posterUrl: "URL", genres: [], releaseDate: Date.now),
  ]

  var mockMovies: [MovieSummary] { mockMoviesRM.toDM() }

  var mockFavoriteMoviesId: [Int] { [mockMoviesRM.first!.id] }

  var mockFavoriteMovies: [MovieSummary] {
    mockMovies.filter { movie in
      mockFavoriteMoviesId.contains { $0 == movie.id}
    }
  }

  let mockMovieRMFavorite: MovieDetailRM = .init(
    id: 1,
    backdropUrl: "url",
    title: "Movie Detail",
    voteAverage: 10.0,
    runtime: 120,
    genres: [],
    releaseDate: Date.now,
    budget: 1000,
    overview: "Overview")

  let mockMovieRMNotFavorite: MovieDetailRM = .init(
    id: 2,
    backdropUrl: "url",
    title: "Movie Detail",
    voteAverage: 10.0,
    runtime: 120,
    genres: [],
    releaseDate: Date.now,
    budget: 1000,
    overview: "Overview")

  var mockMovieFavorite: MovieDetail { mockMovieRMFavorite.toDM(isFavorite: true) }
  var mockMovieNotFavorite: MovieDetail { mockMovieRMNotFavorite.toDM(isFavorite: false) }

  override func setUp() {
    movieRDS = MockMovieRemoteDataSource(provider: MoyaProvider<MovieProvider>())
    userPreferencesCDS = MockUserPreferencesCacheDataSource()
    repository = MoviesRepository(
      movieRDS: movieRDS,
      userPreferencesCDS: userPreferencesCDS)
  }

  override func tearDown() {
    repository = nil
    movieRDS = nil
    userPreferencesCDS = nil
  }

  // MARK: - GetMovieSummaryList
  func testGetMovieSummaryList() {
    stub(movieRDS) { stub in
      when(stub.getMovieSummaryList()).thenReturn(Single.just(mockMoviesRM))
    }

    let sut = repository.getMovieSummaryList().toBlocking()

    XCTAssertEqual([try sut.first()], [mockMovies])
  }

  func testGetMovieSummaryListOnlyFavorites() {
    stub(movieRDS) { stub in
      when(stub.getMovieSummaryList()).thenReturn(Single.just(mockMoviesRM))
    }
    stub(userPreferencesCDS) { stub in
      when(stub.getFavoriteMovies()).thenReturn(Single.just(mockFavoriteMoviesId))
    }

    let sut = repository.getMovieSummaryList(onlyFavoriteMovies: true).toBlocking()

    XCTAssertEqual([try sut.first()], [mockFavoriteMovies])
    verify(userPreferencesCDS).getFavoriteMovies()
  }

  // MARK: - GetMovieDetail
  func testGetMovieDetailIsFavorite() {
    let id = 1

    stub(movieRDS) { stub in
      when(stub.getMovieDetail(id: id)).thenReturn(Single.just(mockMovieRMFavorite))
    }
    stub(userPreferencesCDS) { stub in
      when(stub.getFavoriteMovies()).thenReturn(Single.just(mockFavoriteMoviesId))
    }

    let sut = repository.getMovieDetail(id: id).toBlocking()

    XCTAssertEqual([try sut.first()], [mockMovieFavorite])
  }

  func testGetFavoriteMovieIsNotFavorite() {
    let id = 2

    stub(movieRDS) { stub in
      when(stub.getMovieDetail(id: id)).thenReturn(Single.just(mockMovieRMNotFavorite))
    }
    stub(userPreferencesCDS) { stub in
      when(stub.getFavoriteMovies()).thenReturn(Single.just(mockFavoriteMoviesId))
    }

    let sut = repository.getMovieDetail(id: id).toBlocking()

    XCTAssertEqual([try sut.first()], [mockMovieNotFavorite])
  }

  func testFavoriteMovie() {
    stub(userPreferencesCDS) { stub in
      when(stub.addFavoriteMovie(id: any()))
        .thenReturn(Completable.empty())
    }

    let sut = scheduler.start {
      self.repository.favoriteMovie(with: 1).asObservable()
    }

    XCTAssertEqual(sut.events, [.completed(200)])
    verify(userPreferencesCDS).addFavoriteMovie(id: 1)
  }

  func testUnfavoriteMovie() {
    stub(userPreferencesCDS) { stub in
      when(stub.removeFavoriteMovie(id: any()))
        .thenReturn(Completable.empty())
    }

    let sut = scheduler.start {
      self.repository.unfavoriteMovie(with: 1).asObservable()
    }

    XCTAssertEqual(sut.events, [.completed(200)])
    verify(userPreferencesCDS).removeFavoriteMovie(id: 1)
  }
}
