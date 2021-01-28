//
//  CurrencyExchangeCell.swift
//  ExchangeTestApp
//
//  Created by Vladimir on 27.01.2021.
//

import UIKit

class CurrencyExchangeCell: UICollectionViewCell
{
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    static let cellId = "CurrencyExchangeCellId"
    public var currency: Currency? {
        didSet {
            guard let currency = currency else { return }
            self.setupData(data: currency)
        }
    }
    
    override init(frame: CGRect)
    {
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

        [currencyLabel,
        ]
        .forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints()
    {
        let currencyLabelConstraints = [
            currencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            currencyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
        ]
        
        [currencyLabelConstraints]
            .forEach(NSLayoutConstraint.activate(_:))
    }
    
    
    private func setupData(data: Currency)
    {
        currencyLabel.text = data.code
    }
}
