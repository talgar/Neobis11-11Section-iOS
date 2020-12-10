//
//  Charts.swift
//  CryptoApp
//
//  Created by admin on 10.12.2020.
//

import Foundation

struct Charts : Codable {
    let Data : DataInfo?
}

struct DataInfo : Codable {
    let Data : [ChartsInfo]?
}

struct ChartsInfo : Codable {
    let close: Double?
    let open: Double?
}
