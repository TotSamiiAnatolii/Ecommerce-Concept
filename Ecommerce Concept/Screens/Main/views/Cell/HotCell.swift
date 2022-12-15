//
//  HotCell.swift
//  Ecommerce Concept
//
//  Created by APPLE on 03.12.2022.
//

import UIKit

final class HotCell: UICollectionViewCell {
    
    static let identifire = "HotCell"
    
    private let newIconView = UIView()
        .setStyle()
        .setColor(color: Colors.orange)
    
    private let newIconLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.new!)
        .setTextColor(color: .white)
    
    private let titleLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.markProBold!)
        .setTextColor(color: .white)
    
    private let detailsLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.detailDescription!)
        .setTextColor(color: .white)
    
    private let productDescriptionStack = UIStackView()
        .myStyleStack(
            spacing: 7,
            alignment: .fill ,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: false)
    
    private let buyNowButton = UIButton()
        .setMyStyle(backgroundColor: .white)
        .setTitle(
            font: Fonts.buyNow!,
            title: "Buy now!",
            color: Colors.darkBlue)
        .setRoundCorners(radius: 5)
    
    private let activityIndicatorView = UIActivityIndicatorView()
    
    private let productPhoto = UIImageView()
        .setMyStyle()
    
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
        newIconView.layer.cornerRadius = 13.5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productPhoto.image = nil
        self.newIconLabel.text = nil
        self.titleLabel.text = nil
        self.detailsLabel.text = nil
    }
    
    //MARK: View hierarhies
    private func setViewHierarhies() {
        contentView.addSubview(productPhoto)
        contentView.addSubview(newIconView)
        contentView.addSubview(buyNowButton)
        newIconView.addSubview(newIconLabel)
        contentView.addSubview(productDescriptionStack)
        productDescriptionStack.addArrangedSubview(titleLabel)
        productDescriptionStack.addArrangedSubview(detailsLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            productPhoto.topAnchor.constraint(equalTo: contentView.topAnchor),
            productPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productPhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newIconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            newIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            newIconView.widthAnchor.constraint(equalToConstant: 27),
            newIconView.heightAnchor.constraint(equalToConstant: 27)
        ])
        
        NSLayoutConstraint.activate([
            newIconLabel.centerXAnchor.constraint(equalTo: newIconView.centerXAnchor),
            newIconLabel.centerYAnchor.constraint(equalTo: newIconView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            productDescriptionStack.topAnchor.constraint(equalTo: newIconView.bottomAnchor, constant: 26),
            productDescriptionStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            buyNowButton.widthAnchor.constraint(equalToConstant: 98),
            buyNowButton.heightAnchor.constraint(equalToConstant: 23),
            buyNowButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            buyNowButton.topAnchor.constraint(equalTo: productDescriptionStack.bottomAnchor, constant: 15)
        ])
        
    }
    
    private func setupCorenerRadiusCell() {
        let radius: CGFloat = 10
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}
extension HotCell: ConfigurableView {
    typealias Model = ModelHotCell
    
    func configure(with model: ModelHotCell) {
        if model.new == true {
            self.newIconView.isHidden = false
            self.newIconLabel.isHidden = false
        } else {
            self.newIconLabel.isHidden = true
            self.newIconView.isHidden = true
        }
        self.productPhoto.image = model.productPhoto
        self.newIconLabel.text = "New"
        self.titleLabel.text = model.title
        self.detailsLabel.text = model.detail
    }
}
