//
//  CoinData.swift
//  Coin App
//
//  Created by Administrator on 18/06/2023.
//

import Foundation

struct CoinData : Decodable {
    let time: String
    let assetIdBase: String
    let assetIdQuote: String
    let rate: Double
    
    private enum CodingKeys: String, CodingKey {
        case time
        case assetIdBase = "asset_id_base"
        case assetIdQuote = "asset_id_quote"
        case rate
    }
    
    func toCoinModel() -> CoinModel {
        var formater = ISO8601DateFormatter()
        var date = formater.date(from: time) ?? Date()
        return CoinModel(time: date, from: assetIdBase, to: assetIdQuote, value: rate)
    }
}
