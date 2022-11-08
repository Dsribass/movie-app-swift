//
//  UseCase.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import RxSwift

// MARK: - Protocols
public protocol ObservableUseCase {
  associatedtype Request
  associatedtype Response

  func execute(with req: Request) -> Observable<Response>
}

public protocol SingleUseCase {
  associatedtype Request
  associatedtype Response

  func execute(with req: Request) -> Single<Response>
}

public protocol CompletableUseCase {
  associatedtype Request

  func execute(with req: Request) -> Completable
}
