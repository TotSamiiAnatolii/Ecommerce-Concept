//
//  MyButtonFromAndTo.swift
//  Ecommerce Concept
//
//  Created by APPLE on 11.12.2022.
//

import UIKit

struct ModelMyButtonFromAndTo {
    let title: String
    let image: UIImage = UIImage(systemName: "chevron.down")!
}

class MyButtonFromAndTo: UIButton {

    private var model: ModelMyButtonFromAndTo?
    
    private let title = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.fromAndTo!)
        .setTextColor(color: Colors.darkBlue)
    
    private let arrowDown = UIImageView()
        .setMyStyle()
        .setTintColor(color: .gray)
    
    
    override init(frame: CGRect) {
        self.model = nil
        super.init(frame: frame)
        detailsSettings()
        setViewHierarhies()
        setConstraints()
    }

    init(model: ModelMyButtonFromAndTo) {
        self.model = model
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func detailsSettings() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.borderFromAndTo
    }
    
    private func setViewHierarhies() {
        self.addSubview(title)
        self.addSubview(arrowDown)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            arrowDown.widthAnchor.constraint(equalToConstant: 18),
            arrowDown.heightAnchor.constraint(equalToConstant: 20),
            arrowDown.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            arrowDown.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configure(model: ModelMyButtonFromAndTo) {
        self.title.text = model.title
        self.arrowDown.image = model.image
    }
}
