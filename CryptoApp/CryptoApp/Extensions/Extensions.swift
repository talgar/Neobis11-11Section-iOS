//
//  Extensions.swift
//  CryptoApp
//
//  Created by admin on 10.12.2020.
//

import Foundation

extension Double {
    func roundedCrypto(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}


