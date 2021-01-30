//
//  UserWorker.swift
//  ExchangeTestApp
//
//  Created by Vladimir on 30.01.2021.
//

import Foundation

class UserWorker
{
    var userStore: UserStoreProtocol
    
    init(userStore: UserStoreProtocol)
    {
        self.userStore = userStore
    }
    
    func fetchUser(completionHandler: @escaping (User) -> Void)
    {
        userStore.fetchUser { (user: () throws -> User) -> Void in
        do {
          let user = try user()
          DispatchQueue.main.async {
            completionHandler(user)
          }
        } catch {
          DispatchQueue.main.async {
            completionHandler(User(wallets: []))
          }
        }
      }
    }
    
    func refillUserWallet(currencyCode: String, value: Float, completionHandler: @escaping (User) -> Void)
    {
        userStore.refillUserWallet(currencyCode: currencyCode, value: value) { (user: () throws -> User) -> Void in
        do {
          let user = try user()
          DispatchQueue.main.async {
            completionHandler(user)
          }
        } catch {
          DispatchQueue.main.async {
            completionHandler(User(wallets: []))
          }
        }
      }
    }
}

protocol UserStoreProtocol
{
    func fetchUser(completionHandler: @escaping (() throws -> User) -> Void)
    func refillUserWallet(currencyCode: String, value: Float, completionHandler: @escaping (() throws -> User) -> Void)
}
