//
//  Currency.swift
//  ExchangeTestApp
//
//  Created by Vladimir Mikhaylov on 28.01.2021.
//

import Foundation

struct Currency: Encodable, Equatable
{
    var code: String
    var value: Float
}

func ==(lhs: Currency, rhs: Currency) -> Bool
{
    return lhs.code == rhs.code
}
