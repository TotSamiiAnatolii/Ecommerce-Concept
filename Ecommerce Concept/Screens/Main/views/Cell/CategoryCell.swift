//
//  CategoryCell.swift
//  Ecommerce Concept
//
//  Created by APPLE on 03.12.2022.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.circleView.backgroundColor = Colors.orange
                imageCategory.tintColor = .white
            } else {
                self.circleView.backgroundColor = .white
                imageCategory.tintColor = #colorLiteral(red: 0.7019592524, green: 0.7019620538, blue: 0.761980474, alpha: 1)
            }
        }
    }
    
    static let identifire = "CategoryCell"
    
    private let circleView = UIView()
        .setStyle()
    
    private let imageCategory = UIImageView()
        .setMyStyle()
    
    private let nameCategory = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.markProRegular!)
        .setTextColor(color: Colors.darkBlue)
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackGround
        imageCategory.tintColor = #colorLiteral(red: 0.7019592524, green: 0.7019620538, blue: 0.761980474, alpha: 1)
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleView.layer.cornerRadius = 35.5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameCategory.text = nil
        imageCategory.image = nil
    }
    
    //MARK: View hierarhies
    private func setViewHierarhies() {
        circleView.addSubview(imageCategory)
        contentView.addSubview(circleView)
        contentView.addSubview(nameCategory)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            nameCategory.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            nameCategory.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            circleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 71),
            circleView.heightAnchor.constraint(equalToConstant: 71),
            circleView.bottomAnchor.constraint(equalTo: nameCategory.topAnchor, constant: -6)
        ])
        
        NSLayoutConstraint.activate([
            imageCategory.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            imageCategory.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            imageCategory.widthAnchor.constraint(equalToConstant: 38),
            imageCategory.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
}
extension CategoryCell: ConfigurableView {
    typealias Model = CategoryModel
    
    func configure(with model: CategoryModel) {
        self.imageCategory.image = UIImage(named: model.image)
        self.nameCategory.text = model.name
    }
}
