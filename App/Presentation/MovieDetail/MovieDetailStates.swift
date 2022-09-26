//
//  MovieDetailStates.swift
//  App
//
//  Created by Daniel de Souza Ribas on 07/06/22.
//

import Foundation

protocol MovieDetailStates {
  func startLoading()
  func stopLoading()
  func showError()
  func showSuccess(movieDetail: MovieDetailVM)
}
