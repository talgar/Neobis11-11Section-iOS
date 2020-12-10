//
//  ServerManager.swift
//  CryptoApp
//
//  Created by admin on 08.12.2020.
//

import Foundation
import Alamofire

struct UrlPoints {
    let cryptoList = "https://min-api.cryptocompare.com/data/top/totalvolfull?limit=10&"
    let tsym = "tsym=USD"
    let key = "fba302edfc8ef66a86a95a89201a2378b546167c7efda7b79ac6b42afd5b5bdd"
    let cryptoHistory = "https://min-api.cryptocompare.com/data/v2/histoday?fsym="
    var cryptoName : String?
    
    static let instance = UrlPoints()
}

class ServerManager {
    
    static let instance = ServerManager()
    var urlPoints = UrlPoints.instance
    
    func loadCryptoInfo(completion: @escaping (Crypto)->()){
        let url = "\(urlPoints.cryptoList)\(urlPoints.tsym)&api_key=\(urlPoints.key)"
        AF.request(url).validate().responseDecodable(of: Crypto.self) {(response) in
            guard let data = response.value else { return}
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
    func loadChartsInfo(completion: @escaping (Charts)->()) {
        let url = "\(urlPoints.cryptoHistory)\(urlPoints.cryptoName!)&\(urlPoints.tsym)&limit=30&api_key=\(urlPoints.key)"
        AF.request(url).validate().responseDecodable(of: Charts.self) {(response) in
            guard let data = response.value else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}
