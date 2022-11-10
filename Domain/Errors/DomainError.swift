//
//  DomainError.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 01/11/22.
//

public enum DomainError: Error, Equatable {
  case unauthorized
  case forbidden
  case badRequest
  case notFound
  case serverError
  case noConnectivity
  case decodingError
  case unexpected(baseError: Error?)

  public static func == (lhs: DomainError, rhs: DomainError) -> Bool {
    switch (lhs, rhs) {
    case (.noConnectivity, .noConnectivity):
      return true
    case (.unauthorized, .unauthorized):
      return true
    case (.forbidden, .forbidden):
      return true
    case (.badRequest, .badRequest):
      return true
    case (.notFound, .notFound):
      return true
    case (.serverError, .serverError):
      return true
    case (.decodingError, .decodingError):
      return true
    case (.unexpected, .unexpected):
      return true
    default: return false
    }
  }
}
