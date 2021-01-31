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
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.textColor = .black
        return view
    }()
    
    private let currentCurrencyBalanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    public let exchangeValueInput: UITextField = {
        let view = UITextField()
        view.placeholder = "0.0"
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.textColor = .black
        view.textAlignment = .right
        view.keyboardType = .numberPad
        return view
    }()
    
    public let exchangeFromToLabel: UILabel = {
        let label = UILabel()
        label.text = "€1.0 = €1.0"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    public var completionHandlerChangeValueInputCurrency: ((_ text: String?) -> Void)?
    
    static let cellId = "CurrencyExchangeCellId"
    public var currencyCard: CurrencyExchange.CurrencyExchangeCard? {
        didSet {
            guard let currencyCard = currencyCard else { return }
            self.setupData(data: currencyCard)
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        setupTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews()
    {
        backgroundColor = .blue
        contentView.backgroundColor = .red

        [currencyLabel,
         currentCurrencyBalanceLabel,
         exchangeValueInput,
         exchangeFromToLabel,
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
        
        let currentCurrencyBalanceLabelConstraints = [
            currentCurrencyBalanceLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 20),
            currentCurrencyBalanceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
        ]
        
        let exchangeValueInputConstraints = [
            exchangeValueInput.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            exchangeValueInput.leftAnchor.constraint(equalTo: currentCurrencyBalanceLabel.rightAnchor, constant: 10),
            exchangeValueInput.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
//            exchangeValueInput.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ]
        
        let exchangeFromToLabelConstraints = [
            exchangeFromToLabel.topAnchor.constraint(equalTo: exchangeValueInput.bottomAnchor, constant: 20),
            exchangeFromToLabel.rightAnchor.constraint(equalTo: exchangeValueInput.rightAnchor, constant: 0),
        ]
        
        [currencyLabelConstraints,
         currentCurrencyBalanceLabelConstraints,
         exchangeValueInputConstraints,
         exchangeFromToLabelConstraints
        ]
            .forEach(NSLayoutConstraint.activate(_:))
    }
    
    private func setupTarget()
    {
        exchangeValueInput.addTarget(self, action: #selector(handlerChangeValue), for: .allEditingEvents)
    }
    
    
    private func setupData(data: CurrencyExchange.CurrencyExchangeCard)
    {
        currentCurrencyBalanceLabel.text = "You have: \(data.userBalance)\(data.currency.symbol)"
        currencyLabel.text = data.currency.code
    }
    
    @objc private func handlerChangeValue() {
        completionHandlerChangeValueInputCurrency?(exchangeValueInput.text)
    }
    
    deinit {
        print("Cell deinited")
    }
}
