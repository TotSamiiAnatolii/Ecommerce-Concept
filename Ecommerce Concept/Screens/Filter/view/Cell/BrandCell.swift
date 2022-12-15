//
//  BrandCell.swift
//  Ecommerce Concept
//
//  Created by APPLE on 13.12.2022.
//

import UIKit

final class BrandCell: UITableViewCell {

    static let identifire = "BrandCell"
    
    public var onAction: (() -> Void)?
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                checkButton.isSelected = true }
            else {
                checkButton.isSelected = false
            }
        }
    }
    
    private let nameBrandLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.productDetails!)
        .setTextColor(color: Colors.darkBlue)
    
    private lazy var checkButton = CheckButton()
        .setMyStyle(backgroundColor: .white)
        .setBorder(width: 1, color: Colors.orange)
        .setRoundCorners(radius: 5)
    
    private let cellStack = UIStackView()
        .myStyleStack(
            spacing: 15,
            alignment: .fill ,
            axis: .horizontal,
            distribution: .equalSpacing,
            userInteraction: false)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setViewHierarhies()
        setConstraints()
        nameBrandLabel.text = "Samsung"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(cellStack)
        cellStack.addArrangedSubview(checkButton)
        cellStack.addArrangedSubview(nameBrandLabel)
    }
    
    private func setConstraints() {
    
        NSLayoutConstraint.activate([
            cellStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            checkButton.widthAnchor.constraint(equalToConstant: 22),
            checkButton.heightAnchor.constraint(equalToConstant: 22)
        ])
      
    }
}
extension BrandCell: ConfigurableView {
    
    typealias Model = ModelBrandCell
    
    func configure(with model: ModelBrandCell) {
        self.nameBrandLabel.text = model.nameBrand
        self.isSelected = model.isSelected
    }
}
