//
//  MainView.swift
//  Ecommerce Concept
//
//  Created by APPLE on 03.12.2022.
//

import UIKit

final class MainView: UIView {
    
    private var onAction: ((mainButton) -> Void)?
    
    public var selectCategoryCollection: UICollectionView!
    
    public var searchController: UISearchController!
    
    public var collectionView: UICollectionView!
    
    private let topIndent: CGFloat = 20
    
    private let leftIndent: CGFloat = 20
    
    private let rightIndent: CGFloat = 20
    
    private let filterRightIndent: CGFloat = 16
    
    private let locationTopIndent: CGFloat = 15
    
    private let margin: CGFloat = 25
    
    private let tabBarView = UIView()
        .setStyle()
        .setColor(color: Colors.darkBlue)
    
    private let selectCategory = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: Fonts.markProBold!)
        .setTextColor(color: Colors.darkBlue)
    
    
    private let viewAllButton = UIButton()
        .setMyStyle(backgroundColor: Colors.mainBackGround)
        .setTitle(font: Fonts.markProMedium!,
                  title: "view all",
                  color: Colors.orange)
    
    private let locationButton = UIButton()
        .setMyStyle(backgroundColor: Colors.mainBackGround)
        .setTitle(font: Fonts.markProMedium!,
                  title: "Zihuatanejo, Gro",
                  color: Colors.darkBlue)
    
    private let geoPin = UIImageView()
        .setMyStyle()
        .setImage(image: Images.geoPin)
    
    private let arrowDown = UIImageView()
        .setMyStyle()
        .setImage(image: Images.arrowDown)
    
    private let explorerLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.explorer!)
        .setTextColor(color: .white)
    
    private lazy var shoppingCart = UIButton()
        .setMyStyle(backgroundColor: Colors.darkBlue)
        .addImage(image: Images.shoppingCart)
        .setTintColor(color: .white)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private lazy var favoritesButton = UIButton()
        .setMyStyle(backgroundColor: Colors.darkBlue)
        .addImage(image: Images.favorites)
        .setTintColor(color: .white)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private lazy var personButton = UIButton()
        .setMyStyle(backgroundColor: Colors.darkBlue)
        .addImage(image: Images.person)
        .setTintColor(color: .white)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private let locationStack = UIStackView()
        .myStyleStack(
            spacing: 8,
            alignment: .fill ,
            axis: .horizontal,
            distribution: .fill,
            userInteraction: false)
    
    private let selectCategoryStack = UIStackView()
        .myStyleStack(
            spacing: 0,
            alignment: .fill ,
            axis: .horizontal,
            distribution: .equalCentering,
            userInteraction: false)
    
    private let tabBarStack = UIStackView()
        .myStyleStack(
            spacing: 50,
            alignment: .fill ,
            axis: .horizontal,
            distribution: .equalSpacing,
            userInteraction: true)
    
    private lazy var filterButton = UIButton()
        .setMyStyle(backgroundColor: Colors.mainBackGround)
        .addImage(image: Images.filter)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private let qrSearchButton = UIButton()
        .setMyStyle(backgroundColor: Colors.orange)
        .addImage(image: Images.qrSearch)
    
    public let labelBadge = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.markProRegular!)
        .setColor(color: .red)
        .setTextColor(color: .white)
        .setRoundCorners(radius: 10)
    
    private func setupSelectCategoryCollection() {
        let layout = UICollectionViewFlowLayout()
        selectCategoryCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        selectCategoryCollection.backgroundColor = Colors.mainBackGround
        selectCategoryCollection.translatesAutoresizingMaskIntoConstraints = false
        selectCategoryCollection.showsHorizontalScrollIndicator = false
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = Colors.mainBackGround
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func searchBarSetup() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField,
           let iconView = textField.leftView as? UIImageView {
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = Colors.orange
        }
        
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString.init(string: " Search", attributes: [.font: Fonts.searchBar!, .foregroundColor: Colors.searhcBar])
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.layer.masksToBounds = true
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.tintColor = Colors.orange
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        searchBarSetup()
        labelBadge.text = "2"
        labelBadge.isHidden = true
        setupSelectCategoryCollection()
        setupCollectionView()
        
        selectCategory.attributedText = NSMutableAttributedString(string: "Select Category", attributes: [NSAttributedString.Key.kern: -0.33])
        
        setViewHierarhies()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        qrSearchButton.layer.cornerRadius = qrSearchButton.frame.height / 2
        
        tabBarView.layer.cornerRadius = tabBarView.frame.height / 2.5
        
        searchController.searchBar.layer.cornerRadius = searchController.searchBar.frame.height / 2
        
    }
    
    private func setViewHierarhies() {
        self.addSubview(collectionView)
        self.addSubview(locationStack)
        self.addSubview(selectCategoryStack)
        self.addSubview(filterButton)
        self.addSubview(selectCategoryCollection)
        self.addSubview(qrSearchButton)
        self.addSubview(searchController.searchBar)
        self.addSubview(tabBarView)
        
        locationStack.addArrangedSubview(geoPin)
        locationStack.addArrangedSubview(locationButton)
        locationStack.addArrangedSubview(arrowDown)
        
        selectCategoryStack.addArrangedSubview(selectCategory)
        selectCategoryStack.addArrangedSubview(viewAllButton)
        
        tabBarView.addSubview(tabBarStack)
        
        tabBarStack.addArrangedSubview(explorerLabel)
        tabBarStack.addArrangedSubview(shoppingCart)
        tabBarStack.addArrangedSubview(favoritesButton)
        tabBarStack.addArrangedSubview(personButton)
        
        tabBarStack.addSubview(labelBadge)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            selectCategoryStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            selectCategoryStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin),
            selectCategoryStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margin),
            selectCategoryStack.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: topIndent),
        ])
        
        NSLayoutConstraint.activate([
            locationStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: locationTopIndent),
            locationStack.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            geoPin.widthAnchor.constraint(equalToConstant: 12),
            geoPin.heightAnchor.constraint(equalToConstant: 15.31)
        ])
        
        NSLayoutConstraint.activate([
            arrowDown.widthAnchor.constraint(equalToConstant: 12),
            arrowDown.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            filterButton.widthAnchor.constraint(equalToConstant: 35),
            filterButton.heightAnchor.constraint(equalToConstant: 27),
            filterButton.centerYAnchor.constraint(equalTo: locationStack.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -filterRightIndent)
        ])
        
        NSLayoutConstraint.activate([
            selectCategoryCollection.topAnchor.constraint(equalTo: selectCategoryStack.bottomAnchor, constant: 6),
            selectCategoryCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftIndent),
            selectCategoryCollection.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            selectCategoryCollection.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            qrSearchButton.widthAnchor.constraint(equalToConstant: 34),
            qrSearchButton.heightAnchor.constraint(equalToConstant: 34),
            qrSearchButton.topAnchor.constraint(equalTo: selectCategoryCollection.bottomAnchor, constant: topIndent),
            qrSearchButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -rightIndent)
        ])
        
        NSLayoutConstraint.activate([
            searchController.searchBar.centerYAnchor.constraint(equalTo: qrSearchButton.centerYAnchor),
            searchController.searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftIndent),
            searchController.searchBar.trailingAnchor.constraint(equalTo: qrSearchButton.leadingAnchor, constant: -10),
            searchController.searchBar.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            tabBarView.widthAnchor.constraint(equalTo: self.widthAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 71)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: qrSearchButton.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            shoppingCart.widthAnchor.constraint(equalToConstant: 18),
            shoppingCart.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        NSLayoutConstraint.activate([
            favoritesButton.widthAnchor.constraint(equalToConstant: 18),
            favoritesButton.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        NSLayoutConstraint.activate([
            personButton.widthAnchor.constraint(equalToConstant: 18),
            personButton.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        NSLayoutConstraint.activate([
            tabBarStack.centerYAnchor.constraint(equalTo: tabBarView.centerYAnchor),
            tabBarStack.centerXAnchor.constraint(equalTo: tabBarView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelBadge.widthAnchor.constraint(equalToConstant: 20),
            labelBadge.heightAnchor.constraint(equalToConstant: 20),
            labelBadge.topAnchor.constraint(equalTo: tabBarStack.topAnchor),
            labelBadge.centerXAnchor.constraint(equalTo: tabBarStack.centerXAnchor)
        ])
    }
    
    @objc private func buttonAction(sender: UIButton) {
        switch sender {
        case shoppingCart:
            onAction?(.shop)
        case favoritesButton:
            onAction?(.favorite)
        case personButton:
            onAction?(.person)
        case filterButton:
            onAction?(.filter)
        default:
            break
        }
    }
}
extension MainView: ConfigurableView {
    typealias Model = ModelMainView
    
    func configure(with model: ModelMainView) {
        self.selectCategory.text = model.selectCategory
        self.onAction = model.onAction
        self.explorerLabel.text = model.explorerLabel
    }
}


