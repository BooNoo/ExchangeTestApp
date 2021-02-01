//
//  CurrencyExchangeInteractor.swift
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

protocol CurrencyExchangeBusinessLogic
{
    func getNavigationTitle(request: CurrencyExchange.SetNavigationTitle.Request)
    func changeExchange(request: CurrencyExchange.ChangeExchange.Request)
    func fetchCurrencies(request: CurrencyExchange.FetchCurrencies.Request)
    func fetchCurrentCurrencyExchange(request: CurrencyExchange.FetchCurrentCurrencyExchange.Request)
    func countExchange(request: CurrencyExchange.CountExchange.Request)
    func exchange(request: CurrencyExchange.Exchange.Request)
}

protocol CurrencyExchangeDataStore
{
    var currencies: [Currency] { get set }
    var user: User? { get set }
}

class CurrencyExchangeInteractor: CurrencyExchangeDataStore
{
    var presenter: CurrencyExchangePresentationLogic?
    var worker: CurrencyExchangeWorker? = CurrencyExchangeWorker()
    var currencies: [Currency] = []
    var user: User?
    var cards: [CurrencyExchange.CurrencyExchangeCard] = []
    var exchangeFromIndex: Int = 0
    var exchangeToIndex: Int = 0
    var valueFrom: Float?
    var valueTo: Float?
        
    func setTitle()
    {
        presenter?.setNavigationTitle(responce: CurrencyExchange.SetNavigationTitle.Response(from: currencies[exchangeFromIndex], to: currencies[exchangeToIndex]))
    }
    
    func updateIndexFromtoChange(_ context: CurrencyExchange.ExchangeContext)
    {
        setTitle()
        fetchCurrentCurrencyExchange(context)
    }
    
    func fetchCurrentCurrencyExchange(_ context: CurrencyExchange.ExchangeContext)
    {
        var exchangeFromValue: Float?
        var exchangeToValue: Float?
        switch context {
        case .From:
            guard let valueTo = valueTo  else { break }
            exchangeFromValue = valueTo * currencies[exchangeFromIndex].value
            exchangeToValue = valueTo
        case .To:
            guard let valueFrom = valueFrom  else { break }
            exchangeToValue = valueFrom * currencies[exchangeToIndex].value
            exchangeFromValue = valueFrom
        }
        valueFrom = exchangeFromValue
        valueTo = exchangeToValue
        let response = CurrencyExchange.FetchCurrentCurrencyExchange.Response(exchangeFromIndex: exchangeFromIndex, exchangeToIndex: exchangeToIndex, exchangeFrom: currencies[exchangeFromIndex], exchangeTo: currencies[exchangeToIndex], exchangeFromValue: exchangeFromValue, exchangeToValue: exchangeToValue, context: context)
        presenter?.presentCurrentCurrencyExchange(response: response)
    }
    
    func getExchangeValue(from: Currency, to: Currency) -> Float
    {
        return to.value / from.value
    }
    
    func initCards()
    {
        cards = []
        for currency in currencies {
            var card = CurrencyExchange.CurrencyExchangeCard(currency: currency, userBalance: 0)
            if let index = user?.wallets.firstIndex(where: { return $0.code == currency.code }) {
                card.userBalance = user?.wallets[index].balance ?? 0.0
            }
            cards.append(card)
        }
        presenter?.presentFetchedCurrencies(response: CurrencyExchange.FetchCurrencies.Response(currenciesCards: cards))
    }
}

extension CurrencyExchangeInteractor: CurrencyExchangeBusinessLogic
{
    func countExchange(request: CurrencyExchange.CountExchange.Request)
    {
        guard let text = request.text else { return }
        let value = Float(text)
        var fromToValue: Float?
        var toFromValue: Float?
        if let value = value {
            switch request.context {
            case .From:
                let exchangeValue =  value * getExchangeValue(from: currencies[exchangeFromIndex], to: currencies[exchangeToIndex])
                toFromValue = exchangeValue
                valueFrom = value
                valueTo = exchangeValue
            case .To:
                let exchangeValue =  value * getExchangeValue(from: currencies[exchangeToIndex], to: currencies[exchangeFromIndex])
                fromToValue = exchangeValue
                valueFrom = exchangeValue
                valueTo = value
            }
        }
        presenter?.presentCountExchange(response: CurrencyExchange.CountExchange.Response(exchangeFromIndex: exchangeFromIndex, exchangeToIndex: exchangeToIndex, exchangeFromToValue: fromToValue, exchangeToFromValue: toFromValue, context: request.context))
    }
    
    func fetchCurrentCurrencyExchange(request: CurrencyExchange.FetchCurrentCurrencyExchange.Request)
    {
        fetchCurrentCurrencyExchange(.From)
    }
    
    func getNavigationTitle(request: CurrencyExchange.SetNavigationTitle.Request)
    {
        setTitle()
    }
    
    func changeExchange(request: CurrencyExchange.ChangeExchange.Request)
    {
        switch request.context {
        case .From:
            exchangeFromIndex = request.index
        case .To:
            exchangeToIndex = request.index
        }
        updateIndexFromtoChange(request.context)
    }
    
    func fetchCurrencies(request: CurrencyExchange.FetchCurrencies.Request)
    {
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async { [weak self] in
            guard let self = self else { return }
//            Thread.sleep(until: Date().addingTimeInterval(3))
            self.worker?.fetchCurrencies(completionHandler: { (currencies) in
                self.worker?.fetchUser(completionHandler: { (user) in
                    DispatchQueue.main.async {
                        self.currencies = currencies
                        self.user = user
                        self.initCards()
                    }
                })
            })
        }
    }
    
    func exchange(request: CurrencyExchange.Exchange.Request)
    {
        guard let value = valueFrom else { return }
        let from = currencies[exchangeFromIndex]
        let to = currencies[exchangeToIndex]
        let addValue: Float = value * getExchangeValue(from: from, to: to)
        let removeValue: Float = -value
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async { [weak self] in
            guard let self = self else { return }
            self.worker?.refillUserWallet(currencyCode: to.code, value: addValue, completionHandler: { (user) in
                self.worker?.refillUserWallet(currencyCode: from.code, value: removeValue, completionHandler: { (user) in
                    DispatchQueue.main.async {
                        self.user = user
                        self.initCards()
                    }
                })
            })
        }
    }
    
}
