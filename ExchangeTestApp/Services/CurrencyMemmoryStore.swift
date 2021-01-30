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
    
    func fetchCurrencies(completionHandler: @escaping (() throws -> [Currency]) -> Void) {
        completionHandler { return type(of: self).currencies }
    }
}
