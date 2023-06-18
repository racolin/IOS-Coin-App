//
//  CoinModel.swift
//  Coin App
//
//  Created by Administrator on 18/06/2023.
//

import Foundation

struct CoinModel : Codable {
    let time: Date
    let from: String
    let to: String
    let value: Double
    
    func getValueString() -> String {
        return String(format: "%.2f \(to)", value)
    }
}
