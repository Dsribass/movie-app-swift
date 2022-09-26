//
//  ViewState.swift
//  App
//
//  Created by Daniel de Souza Ribas on 26/09/22.
//

protocol ViewState {
  associatedtype Success
  
  func startLoading()
  func stopLoading()
  func showError()
  func showSuccess(success: Success)
}
