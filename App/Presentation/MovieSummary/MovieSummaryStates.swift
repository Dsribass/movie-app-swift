//
//  MovieSummaryStates.swift
//  App
//
//  Created by Daniel de Souza Ribas on 31/05/22.
//

import Foundation

protocol MovieSummaryStates {
  func startLoading()
  func stopLoading()
  func showError()
  func showSuccess(movieSummaryList: [MovieSummary])
}
