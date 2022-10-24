//
//  DefaultKeys.swift
//  App
//
//  Created by Daniel de Souza Ribas on 24/10/22.
//

import SwiftyUserDefaults

extension DefaultsKey {
}

extension DefaultsSerializable where Self: Codable {
  public typealias Bridge = DefaultsCodableBridge<Self>
  public typealias ArrayBridge = DefaultsCodableBridge<[Self]>
}

extension DefaultsSerializable where Self: RawRepresentable {
  typealias Bridge = DefaultsRawRepresentableBridge<Self>
  typealias ArrayBridge = DefaultsRawRepresentableArrayBridge<[Self]>
}
