//
//  CurrenncyMemmoryStore.swift
//  ExchangeTestApp
//
//  Created by Vladimir Mikhaylov on 28.01.2021.
//

import Foundation

class CurrencyMemmoryStore: CurrencyStoreProtocol
{
    
    static var currencies: [Currency] = [
        Currency(code: "EUR", value: 1.0, symbol: "€"),
        Currency(code: "USD", value: 1.2091, symbol: "$"),
        Currency(code: "GBP", value: 0.88603, symbol: "₤"),
    ]
    static var currenciesTwo: [Currency] = [
        Currency(code: "EUR", value: 1.0, symbol: "€"),
        Currency(code: "USD", value: 1.0091, symbol: "$"),
        Currency(code: "GBP", value: 0.78603, symbol: "₤"),
    ]
    
    static var currenciesTree: [Currency] = [
        Currency(code: "EUR", value: 1.0, symbol: "€"),
        Currency(code: "USD", value: 1.3091, symbol: "$"),
        Currency(code: "GBP", value: 0.98603, symbol: "₤"),
    ]
    
    
    //simulate different currency value
    func fetchCurrencies(completionHandler: @escaping (() throws -> [Currency]) -> Void) {
        let randomValue = Int.random(in: 1..<3)
        if (randomValue == 1) {
            completionHandler { return type(of: self).currencies }
        }
        if (randomValue == 2) {
            completionHandler { return type(of: self).currenciesTwo }
        }
        if (randomValue == 3) {
            completionHandler { return type(of: self).currenciesTree }
        }
    }
}
