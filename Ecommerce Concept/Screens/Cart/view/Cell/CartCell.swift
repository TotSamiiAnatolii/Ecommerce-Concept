//
//  CartCell.swift
//  Ecommerce Concept
//
//  Created by APPLE on 06.12.2022.
//

import UIKit

final class CartCell: UITableViewCell {
    
    static let identifire = "CartCell"
    
    private var onAction: ((UIButton) -> Void)?
    
    public let addCount = CustomAddCount()
        .setRoundCorners(radius: 12)
    
    private let productPhoto = UIImageView()
        .setMyStyle()
        .setRoundCorners(radius: 10)
    
    private let productTitle = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: Fonts.cartProductTitle!)
        .setTextColor(color: .white)
    
    private let priceProduct = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.cartProductTitle!)
        .setTextColor(color: Colors.orange)
    
    private lazy var trashButton = UIButton()
        .setMyStyle(backgroundColor: Colors.darkBlue)
        .addImage(image: UIImage(systemName: "trash"))
        .setTarget(
            method: #selector(trashAction),
            target: self,
            event: .touchUpInside)
    
    private let descriptonProduct = UIStackView()
        .myStyleStack(
            spacing: 9,
            alignment: .fill ,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: false)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.backgroundColor = Colors.darkBlue
        addCount.translatesAutoresizingMaskIntoConstraints = false
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(productPhoto)
        contentView.addSubview(descriptonProduct)
        contentView.addSubview(trashButton)
        contentView.addSubview(addCount)
        
        descriptonProduct.addArrangedSubview(productTitle)
        descriptonProduct.addArrangedSubview(priceProduct)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            productPhoto.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productPhoto.widthAnchor.constraint(equalToConstant: 87),
            productPhoto.heightAnchor.constraint(equalToConstant: 89)
        ])
        
        NSLayoutConstraint.activate([
            descriptonProduct.leadingAnchor.constraint(equalTo: productPhoto.trailingAnchor, constant: 20),
            descriptonProduct.centerYAnchor.constraint(equalTo: productPhoto.centerYAnchor),
            descriptonProduct.trailingAnchor.constraint(equalTo: addCount.leadingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            addCount.widthAnchor.constraint(equalToConstant: 26),
            addCount.heightAnchor.constraint(equalToConstant: 68),
            addCount.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addCount.trailingAnchor.constraint(equalTo: trashButton.leadingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            trashButton.widthAnchor.constraint(equalToConstant: 15),
            trashButton.heightAnchor.constraint(equalToConstant: 16),
            trashButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trashButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }
    
    @objc func trashAction(sender: UIButton) {
        onAction?(sender)
    }
}
extension CartCell: ConfigurableView {
    
    typealias Model = ModelCartCell
    
    func configure(with model: ModelCartCell) {
        self.productTitle.text = model.titleProduct
        self.priceProduct.text = NumberFormatter.formatToCurrency(maximumFractionDigits: 2).string(from: model.totalSum as NSNumber)
        self.addCount.countLabel.text = String(model.count)
        self.onAction = model.onAction
        self.productPhoto.image  = model.photo
    }
}
