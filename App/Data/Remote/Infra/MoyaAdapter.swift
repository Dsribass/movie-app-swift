//
//  MoyaAdapter.swift
//  App
//
//  Created by Daniel de Souza Ribas on 29/09/22.
//

import Foundation
import Moya

class MoyaAdapter<ServiceType: TargetType> {
  let provider = MoyaProvider<ServiceType>()

  func tryDecodeData<ObjectDecodable: Decodable>(
    from data: Data,
    with jsonDecoder: JSONDecoder = JSONDecoder()
  ) -> Result<ObjectDecodable, AppError> {
    do {
      let decoded = try jsonDecoder.decode(ObjectDecodable.self, from: data)
      return .success(decoded)
    } catch {
      return .failure(.decodingError)
    }
  }

  func request(
    target: ServiceType,
    completion: @escaping (Result<Response, AppError>) -> Void
  ) {
    provider.request(target) { result in
      switch result {
      case .success(let response):
        completion(self.getResponseOrMapToAppError(response))
      case let .failure(moyaError):
        completion(.failure(self.mapMoyaErrors(moyaError)))
      }
    }
  }

  private func getResponseOrMapToAppError(
    _ response: (Response)
  ) -> Result<Response, AppError> {
    switch response.statusCode {
    case 200...299:
      return .success(response)
    case 401:
      return .failure(.unauthorized)
    case 403:
      return .failure(.forbidden)
    case 400...499:
      return .failure(.badRequest)
    case 500...599:
      return .failure(.serverError)
    default:
      return .failure(.unexpected(baseError: nil))
    }
  }

  private func mapMoyaErrors(_ moyaError: (MoyaError)) -> AppError {
    switch moyaError {
    case .underlying:
      return .noConnectivity
    default:
      return .unexpected(baseError: moyaError)
    }
  }
}
