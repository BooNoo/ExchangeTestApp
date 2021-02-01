//
//  User.swift
//  ExchangeTestApp
//
//  Created by Vladimir on 30.01.2021.
//

import Foundation

struct User: Codable
{
    var wallets: [CurrencyWallet]
}

struct CurrencyWallet: Codable {
    var code: String
    var balance: Float
}
