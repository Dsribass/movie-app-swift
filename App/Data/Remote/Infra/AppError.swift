//
//  Errors.swift
//  App
//
//  Created by Daniel de Souza Ribas on 29/05/22.
//

import Foundation

enum AppError: Error {
  case unauthorized
  case forbidden
  case badRequest
  case notFound
  case serverError
  case noConnectivity
  case decodingError
  case unexpected(baseError: Error?)
}
