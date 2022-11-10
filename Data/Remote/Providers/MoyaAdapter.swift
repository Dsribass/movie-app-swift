//
//  MoyaAdapter.swift
//  Data
//
//  Created by Daniel de Souza Ribas on 08/11/22.
//

import Foundation
import Moya
import RxSwift
import RxMoya

public class MoyaAdapter<ProviderType: TargetType> {
  public init() {}

  private let provider = MoyaProvider<ProviderType>()

  public func request(
    _ token: ProviderType,
    callbackQueue: DispatchQueue? = nil
  ) -> Single<Response> {
    provider.rx
      .request(token)
      .mapDomainError()
  }
}
