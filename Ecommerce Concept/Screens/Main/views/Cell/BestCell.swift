//
//  BestCell.swift
//  Ecommerce Concept
//
//  Created by APPLE on 03.12.2022.
//

import UIKit

final class BestCell: UICollectionViewCell {
    
    static let identifire = "BestCell"
    
    private let productPhoto = UIImageView()
        .setMyStyle()
    
    private let productTitle = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.titleProduct!)
        .setTextColor(color: Colors.darkBlue)
    
    private let priceDiscount = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.priceNoDiscont!)
        .setTextColor(color: Colors.priceNoDiscont)
    
    private let priceNoDiscount = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.priceDiscont!)
        .setTextColor(color: Colors.darkBlue)
    
    
    private lazy var favoritesButton = LikeButton()
        .setMyStyle(backgroundColor: .white)
        .addImage(image: Images.favorites)
        .setTintColor(color: Colors.orange)
        .setTarget(
            method: #selector(likeButtonAction),
            target: self,
            event: .touchUpInside)
    
    private let priceStack = UIStackView()
        .myStyleStack(
            spacing: 7,
            alignment: .fill ,
            axis: .horizontal,
            distribution: .equalCentering,
            userInteraction: false)
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupCorenerRadiusCell()
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.favoritesButton.layer.cornerRadius = 12.5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.priceNoDiscount.text = nil
        self.priceDiscount.text =  nil
        self.productTitle.text = nil
        self.productPhoto.image = nil
    }
    
    //MARK: View hierarhies
    private func setViewHierarhies() {
        contentView.addSubview(productPhoto)
        contentView.addSubview(productTitle)
        contentView.addSubview(priceStack)
        contentView.addSubview(favoritesButton)
        priceStack.addArrangedSubview(priceNoDiscount)
        priceStack.addArrangedSubview(priceDiscount)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            productTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            productTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            productPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productPhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productPhoto.topAnchor.constraint(equalTo: contentView.topAnchor),
            productPhoto.bottomAnchor.constraint(equalTo: priceStack.topAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            priceStack.bottomAnchor.constraint(equalTo: productTitle.topAnchor, constant: -5),
            priceStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            favoritesButton.widthAnchor.constraint(equalToConstant: 25),
            favoritesButton.heightAnchor.constraint(equalToConstant: 25),
            favoritesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            favoritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
        
    }
    
    @objc func likeButtonAction(sender: UIButton) {
        sender.isSelected = sender.isSelected == true ? false : true
    }
    
    private func setupCorenerRadiusCell() {
        let radius: CGFloat = 10
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}
extension BestCell: ConfigurableView {
    
    typealias Model = ModelBestCell
    
    func configure(with model: ModelBestCell) {
        self.priceNoDiscount.text = "$\(model.priceNoDiscount)"
        self.priceDiscount.text =  "$\(model.priceDiscount)"
        self.productTitle.text = model.productTitle
        self.productPhoto.image = model.productPhoto
        self.priceDiscount.setStrikethroughStyle()
    }
}
