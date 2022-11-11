//
//  Utils.swift
//  Presentation
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
