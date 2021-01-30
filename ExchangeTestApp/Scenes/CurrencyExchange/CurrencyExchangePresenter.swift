//
//  CurrencyExchangePresenter.swift
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

protocol CurrencyExchangePresentationLogic
{
    func setNavigationTitle(responce: CurrencyExchange.SetNavigationTitle.Response)
    func presentFetchedCurrencies(response: CurrencyExchange.FetchCurrencies.Response)
    func presentCurrentCurrencyExchange(response: CurrencyExchange.FetchCurrentCurrencyExchange.Response)
    func presentCountExchange(response: CurrencyExchange.CountExchange.Response)
}

class CurrencyExchangePresenter
{
    weak var viewController: CurrencyExchangeDisplayLogic?
    
    func getExchangeValue(from: Currency, to: Currency) -> Float
    {
        return to.value / from.value
    }
    
    func formatFloat(value: Float, minimumFractionDigits: Int, maximumFractionDigits: Int) -> String
    {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    func getExchangeString(from: Currency, to: Currency) -> String
    {
        let exchangeValue = getExchangeValue(from: from, to: to)
        let title = "\(from.symbol)1.0 = \(to.symbol)\(formatFloat(value: exchangeValue, minimumFractionDigits: 1, maximumFractionDigits: 2))"
        return title
    }

}

extension CurrencyExchangePresenter: CurrencyExchangePresentationLogic {
    func presentCountExchange(response: CurrencyExchange.CountExchange.Response) {
        let exchangeFromToValue: String? = response.exchangeFromToValue != nil ? formatFloat(value: response.exchangeFromToValue ?? 0.0, minimumFractionDigits: 0, maximumFractionDigits: 2) : nil
        let exchangeToFromValue: String? = response.exchangeToFromValue != nil ? formatFloat(value: response.exchangeToFromValue ?? 0.0, minimumFractionDigits: 0, maximumFractionDigits: 2) : nil
        viewController?.displayCountExchange(viewModel: CurrencyExchange.CountExchange.ViewModel(exchangeFromIndex: response.exchangeFromIndex, exchangeToIndex: response.exchangeToIndex, exchangeFromToValue: exchangeFromToValue, exchangeToFromValue: exchangeToFromValue, context: response.context))
    }
    
    func presentCurrentCurrencyExchange(response: CurrencyExchange.FetchCurrentCurrencyExchange.Response)
    {
        let exchangeFromTo = getExchangeString(from: response.exchangeFrom, to: response.exchangeTo)
        let exchangeToFrom = getExchangeString(from: response.exchangeTo, to: response.exchangeFrom)
        let viewModel = CurrencyExchange.FetchCurrentCurrencyExchange.ViewModel(exchangeFromIndex: response.exchangeFromIndex, exchangeToIndex: response.exchangeToIndex, exchangeFromTo: exchangeFromTo, exchangeToFrom: exchangeToFrom, context: response.context)
        viewController?.displayCurrentCurrencyExchange(viewModel: viewModel)
    }
    
    func presentFetchedCurrencies(response: CurrencyExchange.FetchCurrencies.Response)
    {
        viewController?.displayFetchedCurrencies(viewModel: CurrencyExchange.FetchCurrencies.ViewModel(currencies: response.currencies))
    }
    
    func setNavigationTitle(responce: CurrencyExchange.SetNavigationTitle.Response)
    {
        let title = getExchangeString(from: responce.from, to: responce.to)
        viewController?.setNavigationTitle(viewModel: CurrencyExchange.SetNavigationTitle.ViewModel(title: title))
    }
}
