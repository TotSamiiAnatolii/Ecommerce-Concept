//
//  Brand.swift
//  Ecommerce Concept
//
//  Created by APPLE on 13.12.2022.
//

import UIKit

final class BrandView: UIView {
    
    private var onActionNavBar: ((NavBarItem) -> Void)?
    
    public var tableView: UITableView!
    
    private let topIndentNavBar: CGFloat = 24
        
    private let leftIndentNavBar: CGFloat = 44
    
    private let rightIndent: CGFloat = 20
    
    private let heightNavBar: CGFloat = 40
    
    private let topIndent: CGFloat = 20

    private let title = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.productDetails!)
        .setTextColor(color: Colors.darkBlue)
    
    private lazy var closeButton = UIButton()
        .setMyStyle(backgroundColor: Colors.darkBlue)
        .addImage(image: UIImage(systemName: "multiply"))
        .setRoundCorners(radius: 10)
        .setTintColor(color: .white)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private lazy var doneButton = UIButton()
        .setMyStyle(backgroundColor: Colors.orange)
        .setTitle(
            font: Fonts.productDetails!,
            title: "Done",
            color: .white)
        .setRoundCorners(radius: 10)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private let navBarStack = UIStackView()
        .myStyleStack(
            spacing: 0,
            alignment: .fill ,
            axis: .horizontal,
            distribution: .fillProportionally,
            userInteraction: true)
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(BrandCell.self, forCellReuseIdentifier: BrandCell.identifire)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureTableView()
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(navBarStack)
        self.addSubview(tableView)
        
        navBarStack.addArrangedSubview(closeButton)
        navBarStack.addArrangedSubview(title)
        navBarStack.addArrangedSubview(doneButton)
    }
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            navBarStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftIndentNavBar),
            navBarStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -rightIndent),
            navBarStack.topAnchor.constraint(equalTo: self.topAnchor, constant: topIndentNavBar)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 37),
            closeButton.heightAnchor.constraint(equalToConstant: 37)
        ])
        
        NSLayoutConstraint.activate([
            doneButton.widthAnchor.constraint(equalToConstant: 86),
            doneButton.heightAnchor.constraint(equalToConstant: 37)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navBarStack.bottomAnchor, constant: topIndent),
            tableView.leadingAnchor.constraint(equalTo: self.navBarStack.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -rightIndent),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func buttonAction(sender: UIButton) {
        switch sender {
        case closeButton:
            onActionNavBar?(.close)
        case doneButton:
            onActionNavBar?(.done)
        default:
            break
        }
    }
}
extension BrandView: ConfigurableView {
    func configure(with model: Model) {
        self.onActionNavBar = model.onAction
        self.title.text = model.title
    }
    
    typealias Model = ModelBrandView
}
