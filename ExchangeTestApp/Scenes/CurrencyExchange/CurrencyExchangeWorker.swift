//
//  CurrencyExchangeWorker.swift
//  ExchangeTestApp
//
//  Created by Vladimir on 27.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class CurrencyExchangeWorker
{
    var currencyMemmoryWorkerApi = CurrencyWorker(currencyStore: CurrencyMemmoryStore())
    
    func fetchCurrencies(completionHandler: @escaping ([Currency]) -> Void)
    {
        self.currencyMemmoryWorkerApi.fetchCurrencies { (currencies) in
            completionHandler(currencies)
        }
    }
}
