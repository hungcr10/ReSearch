import UIKit

//MARK: - CoinManagerDelegate
protocol CoinManagerDelegate: AnyObject {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

class CoinManager {
    static let coinManger = CoinManager()
    weak var delegate: CoinManagerDelegate? // weak
    private let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    private let apiKey = "2FF9610968CA42E490177719185019C4"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR", "VND"]
    
    //MARK: - getCoinPrice
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let bitcoinPrice = self.parseJSON(data: safeData) {
                        let priceString = String(format: "%.1f", bitcoinPrice)
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    //MARK: - parseJSON
    private func parseJSON( data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: data)
            let lastPrice = decodedData.rate
            return lastPrice
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


