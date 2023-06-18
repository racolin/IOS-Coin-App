//
//  CoinManager.swift
//  Coin App
//
//  Created by Administrator on 18/06/2023.
//

import Foundation

protocol CoinManagerDelegate {
    func onFetchSuccess(_ model: CoinModel);
    func onFetchError(_ error: String);
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "YOUR_API_KEY"
    
    var data : [String] = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func fetchDataCurrencyName(_ name: String) {
        print("\(baseURL)\(name)?apiKey=\(apiKey)")
        let url = URL(string: "\(baseURL)\(name)?apiKey=\(apiKey)")
        let session = URLSession(configuration: .default)
        if let safeUrl = url {
            let task = session.dataTask(with: safeUrl) {(data, response, error) in
                if error != nil {
                    delegate?.onFetchError(error!.localizedDescription)
                } else {
                    if let httpResponse = response as? HTTPURLResponse {
                        var code = httpResponse.statusCode
                        switch (code) {
                        case 200:
                            if let safeData = data {
                                if let model = parseJson(data: safeData) {
                                    delegate?.onFetchSuccess(model)
                                }
                            }
                            break
                        case 400:
                            delegate?.onFetchError("Bad Request")
                            break
                        case 401:
                            delegate?.onFetchError("Unauthorized")
                            break
                        case 403:
                            delegate?.onFetchError("Forbidden")
                            break
                        case 429:
                            delegate?.onFetchError("Too many requests")
                            break
                        case 550:
                            delegate?.onFetchError("No data")
                            break
                        default:
                            delegate?.onFetchError("Unkown")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(data: Data) -> CoinModel? {
        do {
            var coinData = try JSONDecoder().decode(CoinData.self, from: data)
            return coinData.toCoinModel()
        } catch {
            delegate?.onFetchError(error.localizedDescription)
        }
        return nil
    }
}
