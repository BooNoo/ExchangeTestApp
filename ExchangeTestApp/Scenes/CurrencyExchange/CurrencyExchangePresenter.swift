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
}

class CurrencyExchangePresenter: CurrencyExchangePresentationLogic
{
  weak var viewController: CurrencyExchangeDisplayLogic?
}

extension CurrencyExchangePresenter {
    func setNavigationTitle(responce: CurrencyExchange.SetNavigationTitle.Response)
    {
        viewController?.setNavigationTitle(viewModel: CurrencyExchange.SetNavigationTitle.ViewModel(title: responce.title))
    }
}