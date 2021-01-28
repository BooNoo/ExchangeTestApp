//
//  CurrencyExchangeCell.swift
//  ExchangeTestApp
//
//  Created by Vladimir on 27.01.2021.
//

import UIKit

class CurrencyExchangeCell: UICollectionViewCell
{
    
    
    
    static let cellId = "CurrencyExchangeCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews()
    {
        backgroundColor = .blue
        contentView.backgroundColor = .red
        
        layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    private func setupConstraints()
    {
//        let contentViewConstraints = [
////            contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
////            contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
//        ]
//        
//        [contentViewConstraints]
//            .forEach(NSLayoutConstraint.activate(_:))

        
    }
}
