//
//  UserMemmoryStore.swift
//  ExchangeTestApp
//
//  Created by Vladimir on 30.01.2021.
//

import Foundation

class UserMemmoryStore: UserStoreProtocol
{

    static var user = User(wallets: [
        CurrencyWallet(code: "EUR", balance: 100.0),
        CurrencyWallet(code: "USD", balance: 100.0),
        CurrencyWallet(code: "GBP", balance: 100.0)
    ])
    
    func fetchUser(completionHandler: @escaping (() throws -> User) -> Void) {
        completionHandler { return type(of: self).user }
    }
    
    func refillUserWallet(currencyCode: String, value: Float, completionHandler: @escaping (() throws -> User) -> Void) {
        if let index = indexOfWalletWithCode(code: currencyCode) {
            type(of: self).user.wallets[index].balance += value
        }
        completionHandler { return type(of: self).user }
    }
    
    
    private func indexOfWalletWithCode(code: String) -> Int?
    {
        return type(of: self).user.wallets.firstIndex { return $0.code == code }
    }

}
