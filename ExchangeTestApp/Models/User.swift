//
//  User.swift
//  ExchangeTestApp
//
//  Created by Vladimir on 30.01.2021.
//

import Foundation

struct User
{
    var wallets: [CurrencyWallet]
}

struct CurrencyWallet {
    var code: String
    var balance: Float
}
