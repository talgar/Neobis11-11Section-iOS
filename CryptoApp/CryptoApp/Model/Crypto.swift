//
//  Model.swift
//  CryptoApp
//
//  Created by admin on 08.12.2020.
//

import Foundation

struct Crypto : Codable {
    let Message : String?
    let Data : [CryptoInfo]?
}

struct CryptoInfo : Codable {
    let CoinInfo : CoinInfo?
    let RAW : Raw?
    let DISPLAY : Display?
}

struct CoinInfo : Codable {
    let Name : String?
    let FullName : String?
    let Internal : String?
}

struct Raw : Codable {
    let USD : UsdRow?
}

struct UsdRow : Codable {
    let MKTCAP : Double?
    let CHANGEPCT24HOUR : Double?
}

struct Display : Codable {
    let USD : UsdDisplay?
}

struct UsdDisplay : Codable {
    let PRICE : String?
    let VOLUME24HOUR : String?
    let CHANGE24HOUR : String?
}



