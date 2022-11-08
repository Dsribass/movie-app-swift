//
//  MovieRemoteDataSourceTests.swift
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

final class MovieRemoteDataSourceTests: XCTestCase {
  let scheduler = TestScheduler(initialClock: 0)

  var moyaAdapter: MockMoyaAdapter<MovieProvider>!
  var movieRDS: MovieRemoteDataSource!

  var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    decoder.dateDecodingStrategy = .formatted(formatter)
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    return decoder
  }

  var mockMoviesRMData: Data {
    mockMoviesRMJson.data(using: String.Encoding.utf8)!
  }

  var mockMoviesRM: [MovieSummaryRM] {
    try! decoder.decode(
      [MovieSummaryRM].self,
      from: mockMoviesRMData)
  }

  override func setUp() {
    moyaAdapter = MockMoyaAdapter()
    movieRDS = MovieRemoteDataSource(provider: moyaAdapter)
  }

  override func tearDown() {
    movieRDS = nil
    moyaAdapter = nil
  }

  func testGetMovieSummaryList() {
    stub(moyaAdapter) { stub in
      when(stub.request(any(MovieProvider.self), callbackQueue: any()))
        .thenReturn(
          Single.just(
            Response(
              statusCode: 200,
              data: mockMoviesRMData
            ))
        )
    }

    let sut = movieRDS.getMovieSummaryList().toBlocking()

    XCTAssertEqual([try sut.first()], [mockMoviesRM])
  }
}

private let mockMoviesRMJson = "[{\"id\":19404,\"vote_average\":9.3,\"title\":\"Dilwale Dulhania Le Jayenge\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/uC6TTUhPpQCmgldGyYveKRAu8JN.jpg\",\"genres\":[\"Comedy\",\"Drama\",\"Romance\"],\"release_date\":\"1995-10-20\"},{\"id\":278,\"vote_average\":8.6,\"title\":\"The Shawshank Redemption\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/9O7gLzmreU0nGkIB6K3BsJbzvNv.jpg\",\"genres\":[\"Drama\",\"Crime\"],\"release_date\":\"1994-09-23\"},{\"id\":238,\"vote_average\":8.6,\"title\":\"The Godfather\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/rPdtLWNsZmAtoZl9PK7S2wE3qiS.jpg\",\"genres\":[\"Drama\",\"Crime\"],\"release_date\":\"1972-03-14\"},{\"id\":372058,\"vote_average\":8.5,\"title\":\"Your Name.\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/xq1Ugd62d23K2knRUx6xxuALTZB.jpg\",\"genres\":[\"Romance\",\"Animation\",\"Drama\"],\"release_date\":\"2016-08-26\"},{\"id\":240,\"vote_average\":8.5,\"title\":\"The Godfather: Part II\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/bVq65huQ8vHDd1a4Z37QtuyEvpA.jpg\",\"genres\":[\"Drama\",\"Crime\"],\"release_date\":\"1974-12-20\"},{\"id\":424,\"vote_average\":8.5,\"title\":\"Schindler\'s List\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/yPisjyLweCl1tbgwgtzBCNCBle.jpg\",\"genres\":[\"Drama\",\"History\",\"War\"],\"release_date\":\"1993-12-15\"},{\"id\":129,\"vote_average\":8.5,\"title\":\"Spirited Away\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/dL11DBPcRhWWnJcFXl9A07MrqTI.jpg\",\"genres\":[\"Animation\",\"Family\",\"Fantasy\"],\"release_date\":\"2001-07-20\"},{\"id\":497,\"vote_average\":8.4,\"title\":\"The Green Mile\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/sOHqdY1RnSn6kcfAHKu28jvTebE.jpg\",\"genres\":[\"Fantasy\",\"Drama\",\"Crime\"],\"release_date\":\"1999-12-10\"},{\"id\":637,\"vote_average\":8.4,\"title\":\"Life Is Beautiful\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/f7DImXDebOs148U4uPjI61iDvaK.jpg\",\"genres\":[\"Comedy\",\"Drama\"],\"release_date\":\"1997-12-20\"},{\"id\":680,\"vote_average\":8.4,\"title\":\"Pulp Fiction\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/dM2w364MScsjFf8pfMbaWUcWrR.jpg\",\"genres\":[\"Thriller\",\"Crime\"],\"release_date\":\"1994-09-10\"},{\"id\":550,\"vote_average\":8.4,\"title\":\"Fight Club\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/adw6Lq9FiC9zjYEpOqfq03ituwp.jpg\",\"genres\":[\"Drama\"],\"release_date\":\"1999-10-15\"},{\"id\":155,\"vote_average\":8.4,\"title\":\"The Dark Knight\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg\",\"genres\":[\"Drama\",\"Thriller\",\"Crime\",\"Thriller\"],\"release_date\":\"2008-07-16\"},{\"id\":539,\"vote_average\":8.4,\"title\":\"Psycho\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/81d8oyEFgj7FlxJqSDXWr8JH8kV.jpg\",\"genres\":[\"Drama\",\"Horror\",\"Thriller\"],\"release_date\":\"1960-06-16\"},{\"id\":311,\"vote_average\":8.4,\"title\":\"Once Upon a Time in America\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/fqP3Q7DWMFqW7mh11hWXbNwN9rz.jpg\",\"genres\":[\"Drama\",\"Crime\"],\"release_date\":\"1984-05-23\"},{\"id\":389,\"vote_average\":8.4,\"title\":\"12 Angry Men\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/3W0v956XxSG5xgm7LB6qu8ExYJ2.jpg\",\"genres\":[\"Drama\"],\"release_date\":\"1957-03-25\"},{\"id\":244786,\"vote_average\":8.4,\"title\":\"Whiplash\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/lIv1QinFqz4dlp5U4lQ6HaiskOZ.jpg\",\"genres\":[\"Drama\"],\"release_date\":\"2014-10-10\"},{\"id\":13,\"vote_average\":8.4,\"title\":\"Forrest Gump\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/yE5d3BUhE8hCnkMUJOo1QDoOGNz.jpg\",\"genres\":[\"Comedy\",\"Drama\",\"Romance\"],\"release_date\":\"1994-07-06\"},{\"id\":510,\"vote_average\":8.4,\"title\":\"One Flew Over the Cuckoo\'s Nest\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/2Sns5oMb356JNdBHgBETjIpRYy9.jpg\",\"genres\":[\"Drama\"],\"release_date\":\"1975-11-18\"},{\"id\":12477,\"vote_average\":8.4,\"title\":\"Grave of the Fireflies\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/4u1vptE8aXuzb5zauZTmikyectV.jpg\",\"genres\":[\"Animation\",\"Drama\",\"War\"],\"release_date\":\"1988-04-16\"},{\"id\":11216,\"vote_average\":8.4,\"title\":\"Cinema Paradiso\",\"poster_url\":\"https://image.tmdb.org/t/p/w200/khYsM4UEqOY4nM9Bf8ecyZZkCm0.jpg\",\"genres\":[\"Drama\",\"Romance\"],\"release_date\":\"1988-11-17\"}]"
