//
//  MoyaAdapter.swift
//  App
//
//  Created by Daniel de Souza Ribas on 29/09/22.
//

import Foundation
import Moya
import Alamofire

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
    case 404:
      return .failure(.notFound)
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
    case .underlying(let underlyingError as NSError, _):
      let underlyingCode = getUnderlyingCode(underlyingError)
      switch underlyingCode {
      case NSURLErrorNotConnectedToInternet:
        return .noConnectivity
      default:
        return .unexpected(baseError: moyaError)
      }
    default:
      return .unexpected(baseError: moyaError)
    }
  }

  private func getUnderlyingCode(_ error: NSError) -> Int {
    if let underlyingError = (error as? Alamofire.AFError)?.underlyingError {
      return (underlyingError as NSError).code
    } else if let alamofireError = error as? Alamofire.AFError {
      return (alamofireError as NSError).code
    } else {
      return (error as NSError).code
    }
  }
}
