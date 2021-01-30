//
//  CurrencyExchangeView.swift
//  ExchangeTestApp
//
//  Created by Vladimir on 27.01.2021.
//

import UIKit

class CurrencyExchangeView: UIView
{
    
    public var exchangeFromCollectionView: CurrencyExchangeCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = CurrencyExchangeCollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    public var exchangeToCollectionView: CurrencyExchangeCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = CurrencyExchangeCollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()

    init()
    {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews()
    {
        [exchangeFromCollectionView,
         exchangeToCollectionView
        ]
        .forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints()
    {
        let exchangeFromCollectionViewConstraints = [
            exchangeFromCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            exchangeFromCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            exchangeFromCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
        ]
        
        let exchangeToCollectionViewConstraints = [
            exchangeToCollectionView.topAnchor.constraint(equalTo: exchangeFromCollectionView.bottomAnchor, constant: 20),
            exchangeToCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            exchangeToCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
        ]
        
        [exchangeFromCollectionViewConstraints,
         exchangeToCollectionViewConstraints
        ]
            .forEach(NSLayoutConstraint.activate(_:))
    }
    
    public func setupData(data: [Currency])
    {
        exchangeFromCollectionView.data = data
        exchangeFromCollectionView.reloadData()
        
        exchangeToCollectionView.data = data
        exchangeToCollectionView.reloadData()
    }
    
}

class CurrencyExchangeCollectionView: UICollectionView
{
    
    public var data: [Currency] = []
    public var completionHandlerSelectCurrency: ((_ index: Int) -> Void)?
    public var completionHandlerChangeValueInputCurrency: ((_ text: String?) -> Void)?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        addSubviews()
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews()
    {
        backgroundColor = .blue
    }
    
    private func setupConstraints()
    {
        let selfViewConstraints = [
            heightAnchor.constraint(equalToConstant: 150)
        ]
        
        [selfViewConstraints]
            .forEach(NSLayoutConstraint.activate(_:))
    }
    
    private func setupView()
    {
        dataSource = self
        delegate = self
        register(CurrencyExchangeCell.self, forCellWithReuseIdentifier: CurrencyExchangeCell.cellId)
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    deinit {
        print("View deinited")
    }
}

extension CurrencyExchangeCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyExchangeCell.cellId, for: indexPath) as! CurrencyExchangeCell
        cell.currency = data[indexPath.row]
        cell.completionHandlerChangeValueInputCurrency = completionHandlerChangeValueInputCurrency
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.completionHandlerSelectCurrency?(Int(targetContentOffset.pointee.x / frame.width))
    }
}
