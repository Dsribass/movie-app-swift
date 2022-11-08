//
//  DomainError.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 01/11/22.
//

public enum DomainError: Error {
  case unauthorized
  case forbidden
  case badRequest
  case notFound
  case serverError
  case noConnectivity
  case decodingError
  case unexpected(baseError: Error?)
}
