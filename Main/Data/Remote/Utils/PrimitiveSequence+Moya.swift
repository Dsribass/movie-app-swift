//
//  ObservableType+Moya.swift
//  App
//
//  Created by Daniel de Souza Ribas on 20/10/22.
//

import Foundation
import Alamofire
import RxSwift
import Moya

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
  /// Maps moya request errors into application error
  func mapAppError() -> PrimitiveSequence<SingleTrait, Response> {
    return filterSuccessfulStatusCodes()
      .catch { error in
        switch error {
        case MoyaError.statusCode(let response):
          let statusCodeError = mapStatusCodeToAppError(
            with: response.statusCode
          ) ?? AppError.unexpected(baseError: error)
          return Single.error(statusCodeError)

        case MoyaError.underlying(let underlyingError as NSError, _):
          return Single.error(mapUnderlyingErrorToAppError(with: underlyingError))

        default: return Single.error(AppError.unexpected(baseError: error))
        }
      }
  }

  private func mapStatusCodeToAppError(with statusCode: Int) -> AppError? {
    switch statusCode {
    case 401:
      return .unauthorized
    case 403:
      return .forbidden
    case 404:
      return .notFound
    case 400...499:
      return .badRequest
    case 500...599:
      return .serverError
    default:
      return nil
    }
  }


  private func mapUnderlyingErrorToAppError(with underlyingError: NSError) -> AppError {
    let underlyingCode = getUnderlyingCode(underlyingError)

    switch underlyingCode {
    case NSURLErrorNotConnectedToInternet:
      return .noConnectivity
    default:
      return .unexpected(baseError: underlyingError)
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
