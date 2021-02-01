//
//  CurrencyApi.swift
//  ExchangeTestApp
//
//  Created by Vladimir on 01.02.2021.
//

import Foundation

fileprivate struct Envelope: Codable {
    let rates: [String: Float]
}

class CurrencyApi {
    
    let currencyCodes: [String: String] = [
        "USD": "$",
        "GBP": "₤",
    ]
    let defaultCurrency = Currency(code: "EUR", value: 1.0, symbol: "€")
    
    private func fetchApiData(completionHandler: @escaping (Envelope?) -> Void)
    {
        guard let url = URL(string: "https://api.exchangeratesapi.io/latest")  else { return completionHandler(nil)  }
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                return completionHandler(nil)
            }
            guard let data = data else { return completionHandler(nil) }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Envelope.self, from: data)
                completionHandler(response)
            } catch _ {
                completionHandler(nil)
            }
        }.resume()
    }
    
    private func fetchCurrenciesFromApi(completionHandler: @escaping ([Currency]) -> Void)
    {
        fetchApiData { (data) in
            completionHandler(self.prepareData(data: data))
        }
    }
    
    private func prepareData(data: Envelope?) -> [Currency]
    {
        guard let data = data else { return [] }
        var currencies: [Currency] = [defaultCurrency]
        currencyCodes.forEach { (arg) in
            let (key, value) = arg
            guard let rateValue = data.rates[key] else { return }
            let currency = Currency(code: key, value: rateValue, symbol: value)
            currencies.append(currency)
        }
        return currencies
    }
    
}
 
extension CurrencyApi: CurrencyStoreProtocol
{
    func fetchCurrencies(completionHandler: @escaping (() throws -> [Currency]) -> Void)
    {
        fetchCurrenciesFromApi { (currencies) in
            completionHandler { return currencies }
        }
    }
}


