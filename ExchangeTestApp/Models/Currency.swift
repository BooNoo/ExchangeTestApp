//
//  Currency.swift
//  ExchangeTestApp
//
//  Created by Vladimir Mikhaylov on 28.01.2021.
//

import Foundation

struct Currency: Encodable
{
    var code: String
    var value: Float
    var symbol: String
}
