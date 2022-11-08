//
//  UserPreferencesCacheDataSource.swift
//  App
//
//  Created by Daniel de Souza Ribas on 24/10/22.
//

import RxSwift
import SwiftyUserDefaults

public final class UserPreferencesCacheDataSource {
  public init() {}

  func getFavoriteMovies() -> Single<[Int]> {
    Single.just(Defaults.favoriteMovies)
  }

  func addFavoriteMovie(id: Int) -> Completable {
    Defaults.favoriteMovies.append(id)
    return Completable.empty()
  }

  func removeFavoriteMovie(id: Int) -> Completable {
    Defaults.favoriteMovies.removeAll { $0 == id }
    return Completable.empty()
  }
}

extension DefaultsKeys {
  var favoriteMovies: DefaultsKey<[Int]> {
    .init("favoriteMovies", defaultValue: [])
  }
}
