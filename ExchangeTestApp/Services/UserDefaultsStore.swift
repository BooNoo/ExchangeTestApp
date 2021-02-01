//
//  UserDefaultsStore.swift
//  ExchangeTestApp
//
//  Created by Vladimir on 01.02.2021.
//

import Foundation

class UserDefaultsStore: UserStoreProtocol {
    
    private let key = "user"
    
    private func initUser() -> User {
        return save(user: UserMemmoryStore.user)
    }
    
    func save(user: User) -> User {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(user), forKey: key)
        return user
    }
    
    func getOrInitUser() -> User {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            if let user = try? PropertyListDecoder().decode(User.self, from: data) {
                return user
            }
            return initUser()
        }
        return initUser()
    }
    
    func fetchUser(completionHandler: @escaping (() throws -> User) -> Void) {
        completionHandler { getOrInitUser() }
    }
    
    func refillUserWallet(currencyCode: String, value: Float, completionHandler: @escaping (() throws -> User) -> Void) {
        var user = getOrInitUser()
        if let index = indexOfWalletWithCode(user: user, code: currencyCode) {
            user.wallets[index].balance += value
        }
        user = save(user: user)
        completionHandler { user }
    }
    
    private func indexOfWalletWithCode(user: User, code: String) -> Int?
    {
        return user.wallets.firstIndex { return $0.code == code }
    }
}
