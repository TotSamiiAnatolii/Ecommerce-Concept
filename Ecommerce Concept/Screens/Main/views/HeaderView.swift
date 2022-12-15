//
//  HeaderView.swift
//  Ecommerce Concept
//
//  Created by APPLE on 05.12.2022.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    
    static let identifire = "HeaderView"
    
    private let leftIndent: CGFloat = 10
    
    private let rightIndent: CGFloat = 10
    
    private let bottomIndent: CGFloat = 5
    
    private let nameCollection = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.markProBold!)
        .setTextColor(color: Colors.darkBlue)
    
    private let seeMoreButton = UIButton()
        .setMyStyle(backgroundColor: Colors.mainBackGround)
        .setTitle(font: Fonts.markProMedium!,
                  title: "see more",
                  color: Colors.orange)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackGround
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    private func setViewHierarhies() {
        self.addSubview(nameCollection)
        self.addSubview(seeMoreButton)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            nameCollection.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            seeMoreButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            seeMoreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
extension HeaderView: ConfigurableView {
    
    func configure(with model: ModelHeaderView) {
        self.nameCollection.text = model.title
    }
    
    typealias Model = ModelHeaderView
}
