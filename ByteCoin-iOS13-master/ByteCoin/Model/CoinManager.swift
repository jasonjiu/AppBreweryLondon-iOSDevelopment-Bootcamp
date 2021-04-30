//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateBitcoin(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "6DF404FF-8BB5-4AA5-9527-2EA42C56B2EE"
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String)  {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"

        // 1. create the url
        if let url = URL(string: urlString){
            // 2. create the urlSession
            let session = URLSession(configuration: .default)
            // 3. give the session a task
            let task = session.dataTask(with: url){ (data, response, err) in
                if err != nil{
                    self.delegate?.didFailWithError(error: err!)
                    return
                }
                
                if let safeData = data {
                    if let bitCoin = self.parseJSON(safeData){
                        let priceString = String(format: "%.2f", bitCoin)
                        self.delegate?.didUpdateBitcoin(price: priceString, currency: currency)
                    }
                    
                }
            }
            // 4. start the task
            task.resume()
        }
    }
    
  
    
    func parseJSON(_ data: Data) -> Double?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodeData.rate
            print(lastPrice)
            return lastPrice
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
    
}
