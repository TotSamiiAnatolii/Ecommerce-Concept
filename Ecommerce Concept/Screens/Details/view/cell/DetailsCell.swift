//
//  DetailsCell.swift
//  Ecommerce Concept
//
//  Created by USER on 05.12.2022.
//

import UIKit

final class DetailsCell: UICollectionViewCell {
    
    static let identifire = "DetailsCell"

    private let photoProduct = UIImageView()
        .setMyStyle()

    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        setupCorenerRadiusCell()
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = self.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    //MARK: View hierarhies
    private func setViewHierarhies() {
        contentView.addSubview(photoProduct)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            photoProduct.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            photoProduct.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            photoProduct.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            photoProduct.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupCorenerRadiusCell() {
        let radius: CGFloat = 20
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}
extension DetailsCell: ConfigurableView {
    typealias Model = ModelDetailsCell
    
    func configure(with model: ModelDetailsCell) {
        self.photoProduct.image = model.photoProduct
    }
}
