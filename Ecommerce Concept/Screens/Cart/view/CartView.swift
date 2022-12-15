//
//  CartView.swift
//  Ecommerce Concept
//
//  Created by APPLE on 06.12.2022.
//

import UIKit

final class CartView: UIView {
    
    public var onAction: ((UIButton) -> Void)?
    
    public var tableView: UITableView!
    
    private let title = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.title!)
        .setTextColor(color: Colors.darkBlue)
    
    private lazy var backButton = UIButton()
        .setMyStyle(backgroundColor: Colors.darkBlue)
        .addImage(image: UIImage(systemName: "chevron.left"))
        .setRoundCorners(radius: 10)
        .setTintColor(color: .white)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private let locationLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.markProMedium!)
        .setTextColor(color: Colors.darkBlue)
    
    private let totalLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.markProMedium!)
        .setTextColor(color: .white)
    
    private let totalSumLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.total!)
        .setTextColor(color: .white)
    
    private let deliveryLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.markProMedium!)
        .setTextColor(color: .white)
    
    private let deliveryResultLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.total!)
        .setTextColor(color: .white)
    
    private let locationButton = UIButton()
        .setMyStyle(backgroundColor: Colors.orange)
        .addImage(image: Images.location)
        .setRoundCorners(radius: 10)
        .setTintColor(color: .white)
    
    private let locationStack = UIStackView()
        .myStyleStack(
            spacing: 9,
            alignment: .fill ,
            axis: .horizontal,
            distribution: .equalSpacing,
            userInteraction: false)
    
    private let totalStack = UIStackView()
        .myStyleStack(
            spacing: 10,
            alignment: .fill ,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: false)
    
    private let deliveryStack = UIStackView()
        .myStyleStack(
            spacing: 10,
            alignment: .fill ,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: false)
    
    private let containerView = UIView()
        .setStyle()
        .setRoundCorners(radius: 30)
        .setShadows(
            color: Colors.shadow,
            width: 0.1,
            height: 1,
            radius: 8,
            opacity: 30)
        .setColor(color: Colors.darkBlue)
    
    private let totalCheckContainer = UIView()
        .setStyle()
        .setColor(color: Colors.darkBlue)
    
    private let topBorderView = UIView()
        .setStyle()
        .setColor(color: Colors.borderColor)
    
    private let bottomBorderView = UIView()
        .setStyle()
        .setColor(color: Colors.borderColor)
    
    private let checkOut = UIButton()
        .setMyStyle(backgroundColor: Colors.orange)
        .setTitle(
            font: Fonts.segmentControl!,
            title: "Checkout",
            color: .white)
        .setRoundCorners(radius: 10)
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.darkBlue
        tableView.separatorStyle = .none
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.identifire)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.mainBackGround
        setupTableView()
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setViewHierarhies() {
        self.addSubview(backButton)
        self.addSubview(locationStack)
        self.addSubview(title)
        self.addSubview(containerView)
        
        containerView.addSubview(tableView)
        containerView.addSubview(checkOut)
        containerView.addSubview(totalCheckContainer)
        containerView.addSubview(topBorderView)
        containerView.addSubview(bottomBorderView)
        
        totalCheckContainer.addSubview(totalStack)
        totalCheckContainer.addSubview(deliveryStack)
        
        locationStack.addArrangedSubview(locationLabel)
        locationStack.addArrangedSubview(locationButton)
        
        totalStack.addArrangedSubview(totalLabel)
        totalStack.addArrangedSubview(deliveryLabel)
        
        deliveryStack.addArrangedSubview(totalSumLabel)
        deliveryStack.addArrangedSubview(deliveryResultLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 50),
            title.leadingAnchor.constraint(equalTo: backButton.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            backButton.widthAnchor.constraint(equalToConstant: 37),
            backButton.heightAnchor.constraint(equalToConstant: 37)
        ])
        
        NSLayoutConstraint.activate([
            locationStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            locationStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            locationButton.widthAnchor.constraint(equalToConstant: 37),
            locationButton.heightAnchor.constraint(equalToConstant: 37)
        ])
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 50)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalCheckContainer.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            checkOut.widthAnchor.constraint(equalToConstant: 320),
            checkOut.heightAnchor.constraint(equalToConstant: 54),
            checkOut.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            checkOut.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            totalCheckContainer.widthAnchor.constraint(equalTo: self.widthAnchor),
            totalCheckContainer.heightAnchor.constraint(equalToConstant: 68),
            totalCheckContainer.bottomAnchor.constraint(equalTo: checkOut.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            totalStack.leadingAnchor.constraint(equalTo: totalCheckContainer.leadingAnchor, constant: 55),
            totalStack.centerYAnchor.constraint(equalTo: totalCheckContainer.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            deliveryStack.trailingAnchor.constraint(equalTo: totalCheckContainer.trailingAnchor, constant: -55),
            deliveryStack.centerYAnchor.constraint(equalTo: totalCheckContainer.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            topBorderView.heightAnchor.constraint(equalToConstant: 3),
            topBorderView.bottomAnchor.constraint(equalTo: totalCheckContainer.topAnchor),
            topBorderView.widthAnchor.constraint(equalTo: totalCheckContainer.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomBorderView.heightAnchor.constraint(equalToConstant: 1),
            bottomBorderView.bottomAnchor.constraint(equalTo: totalCheckContainer.bottomAnchor),
            bottomBorderView.widthAnchor.constraint(equalTo: totalCheckContainer.widthAnchor)
        ])
    }
    
    @objc func buttonAction(sender: UIButton) {
        onAction?(sender)
    }
}
extension CartView: ConfigurableView {
    
    typealias Model = ModelCartView
    
    func configure(with model: ModelCartView) {
        self.title.text = model.title
        self.totalLabel.text = model.total
        self.totalSumLabel.text = NumberFormatter.formatToCurrency(maximumFractionDigits: 0).string(from: model.totalSum as NSNumber)
        self.deliveryLabel.text = model.delivery
        self.deliveryResultLabel.text = model.deliveryResult
        self.locationLabel.text = model.location
    }
}
