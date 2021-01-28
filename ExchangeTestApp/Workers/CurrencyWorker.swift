//
//  CurrencyWorker.swift
//  ExchangeTestApp
//
//  Created by Vladimir Mikhaylov on 28.01.2021.
//

import Foundation

class CurrencyWorker
{
    var currencyStore: CurrencyStoreProtocol
    
    init(currencyStore: CurrencyStoreProtocol)
    {
        self.currencyStore = currencyStore
    }
    
    func fetchCurrencies(completionHandler: @escaping ([Currency]) -> Void)
    {
        currencyStore.fetchCurrencies { (currencies: () throws -> [Currency]) -> Void in
        do {
          let currencies = try currencies()
          DispatchQueue.main.async {
            completionHandler(currencies)
          }
        } catch {
          DispatchQueue.main.async {
            completionHandler([])
          }
        }
      }
    }
}

protocol CurrencyStoreProtocol
{
    func fetchCurrencies(completionHandler: @escaping (() throws -> [Currency]) -> Void)
}
