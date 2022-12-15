//
//  DetailsView.swift
//  Ecommerce Concept
//
//  Created by APPLE on 05.12.2022.
//

import UIKit

enum DetailsButton {
    case cart
    case back
    case addCart
}

final class DetailsView: UIView {
    
    private var onAction: ((DetailsButton) -> Void)?
    
    public var collectionView: UICollectionView!
    
    private var colorsControl = ColorControl(frame: .zero)
    
    private var stars: [UIImageView] = []
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let layout = CustomCenteredLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: DetailsCell.identifire)
        collectionView.backgroundColor = Colors.mainBackGround
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setStars(count: Int) {
        
        for _ in 0..<count {
            let star = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            
            star.image = Images.stars
            starStack.addArrangedSubview(star)
        }
    }
    
    private lazy var addToCart = UIButton()
        .setMyStyle(backgroundColor: Colors.orange)
        .setRoundCorners(radius: 10)
        .setTitle(
            font: Fonts.segmentControl!,
            title: "Add to Cart       $1,500.00",
            color: .white)
        .setTarget(
            method: #selector(buttoAction),
            target: self,
            event: .touchUpInside)
    
    private let selectColorLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.selectColor!)
        .setTextColor(color: Colors.darkBlue)
    
    private let cameraImage = UIImageView()
        .setMyStyle()
        .setImage(image: Images.camera)
    
    private let cpuImage = UIImageView()
        .setMyStyle()
        .setImage(image: Images.cpu)
    
    private let sdImage = UIImageView()
        .setMyStyle()
        .setImage(image: Images.sdImage)
    
    private let ssdImage = UIImageView()
        .setMyStyle()
        .setImage(image: Images.ssdImage)
    
    private let cameraLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.detailDescription!)
        .setTextColor(color: Colors.priceNoDiscont)
    
    private let cpuILabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.detailDescription!)
        .setTextColor(color: Colors.priceNoDiscont)
    
    private let sdLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.detailDescription!)
        .setTextColor(color: Colors.priceNoDiscont)
    
    private let ssdLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.detailDescription!)
        .setTextColor(color: Colors.priceNoDiscont)
    
    private let cameraStack = UIStackView()
        .myStyleStack(
            spacing: 9,
            alignment: .center ,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: false)
    
    private let cpuIStack = UIStackView()
        .myStyleStack(
            spacing: 5,
            alignment: .center ,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: false)
    
    private let sdStack = UIStackView()
        .myStyleStack(
            spacing: 9,
            alignment: .center ,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: false)
    
    private let ssdStack = UIStackView()
        .myStyleStack(
            spacing: 9,
            alignment: .center ,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: false)
    
    private lazy var backButton = UIButton()
        .setMyStyle(backgroundColor: Colors.darkBlue)
        .addImage(image: UIImage(systemName: "chevron.left"))
        .setRoundCorners(radius: 10)
        .setTintColor(color: .white)
        .setTarget(
            method: #selector(buttoAction),
            target: self,
            event: .touchUpInside)
    
    private let titleDetails = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.productDetails!)
        .setTextColor(color: Colors.darkBlue)
    
    private lazy var shoppingCart = UIButton()
        .setMyStyle(backgroundColor: Colors.orange)
        .addImage(image: Images.shoppingCart)
        .setRoundCorners(radius: 10)
        .setTarget(
            method: #selector(buttoAction),
            target: self,
            event: .touchUpInside)
    
    private let viewContainer = UIView()
        .setStyle()
        .setRoundCorners(radius: 30)
        .setShadows(
            color: Colors.shadow,
            width: 0.1,
            height: 0.1,
            radius: 5,
            opacity: 15)
        .setColor(color: Colors.mainBackGround)
    
    private let nameProduct = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.markProBold!)
        .setTextColor(color: Colors.darkBlue)
    
    private let favoriteButton = UIButton()
        .setMyStyle(backgroundColor: Colors.darkBlue)
        .addImage(image: Images.favorites)
        .setRoundCorners(radius: 10)
        .setTintColor(color: .white)
    
    private let navBarStack = UIStackView()
        .myStyleStack(
            spacing: 0,
            alignment: .fill ,
            axis: .horizontal,
            distribution: .equalCentering,
            userInteraction: true)
    
    private let featuresStack = UIStackView()
        .myStyleStack(
            spacing: 10,
            alignment: .center ,
            axis: .horizontal,
            distribution: .equalCentering,
            userInteraction: false)
    
    private let starStack = UIStackView()
        .myStyleStack(
            spacing: 9,
            alignment: .fill ,
            axis: .horizontal,
            distribution: .equalSpacing,
            userInteraction: false)
    
    
    
    private func setupColors(colors: [String]) {
        colorsControl = ColorControl(frame: .zero, buttonTitle: ["#772D03", "#010035"])
        colorsControl.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.addSubview(colorsControl)
        
        NSLayoutConstraint.activate([
            colorsControl.topAnchor.constraint(equalTo: selectColorLabel.bottomAnchor, constant: 20),
            colorsControl.leadingAnchor.constraint(equalTo: selectColorLabel.leadingAnchor),
            colorsControl.heightAnchor.constraint(equalToConstant: 39),
            colorsControl.widthAnchor.constraint(equalToConstant: 95)
            
        ])
    }
    
    private func setupCapacity(title: [String]) {
        let customMemory = CapacityControl(frame: .zero, buttonTitle: title)
        customMemory.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.addSubview(customMemory)
        
        NSLayoutConstraint.activate([
            customMemory.centerYAnchor.constraint(equalTo: colorsControl.centerYAnchor),
            customMemory.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -75),
            customMemory.heightAnchor.constraint(equalToConstant: 30),
            customMemory.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.4),
        ])
    }
    
    public let segmentControl = DetailsSegmentedControl(frame: .zero, buttonTitle: ["Shop", "Details", "Features"])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackGround
        self.segmentControl.backgroundColor = .clear
        self.segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        setStars(count: 5)
        
        setupCollectionView()
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(collectionView)
        self.addSubview(viewContainer)
        self.addSubview(navBarStack)
        
        viewContainer.addSubview(nameProduct)
        viewContainer.addSubview(starStack)
        viewContainer.addSubview(favoriteButton)
        viewContainer.addSubview(segmentControl)
        viewContainer.addSubview(featuresStack)
        viewContainer.addSubview(selectColorLabel)
        viewContainer.addSubview(addToCart)
        
        navBarStack.addArrangedSubview(backButton)
        navBarStack.addArrangedSubview(titleDetails)
        navBarStack.addArrangedSubview(shoppingCart)
        
        featuresStack.addArrangedSubview(cpuIStack)
        featuresStack.addArrangedSubview(cameraStack)
        featuresStack.addArrangedSubview(ssdStack)
        featuresStack.addArrangedSubview(sdStack)
        
        cameraStack.addArrangedSubview(cameraImage)
        cameraStack.addArrangedSubview(cameraLabel)
        
        cpuIStack.addArrangedSubview(cpuImage)
        cpuIStack.addArrangedSubview(cpuILabel)
        
        sdStack.addArrangedSubview(sdImage)
        sdStack.addArrangedSubview(sdLabel)
        
        ssdStack.addArrangedSubview(ssdImage)
        ssdStack.addArrangedSubview(ssdLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            navBarStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            navBarStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            navBarStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            viewContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.48),
            viewContainer.widthAnchor.constraint(equalTo: self.widthAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navBarStack.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: viewContainer.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            nameProduct.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 25),
            nameProduct.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 25),
            nameProduct.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            starStack.leadingAnchor.constraint(equalTo: nameProduct.leadingAnchor),
            starStack.topAnchor.constraint(equalTo: nameProduct.bottomAnchor, constant: 7)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -25),
            favoriteButton.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 25),
            favoriteButton.widthAnchor.constraint(equalToConstant: 37),
            favoriteButton.heightAnchor.constraint(equalToConstant: 37)
        ])
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 37),
            backButton.heightAnchor.constraint(equalToConstant: 37)
        ])
        
        NSLayoutConstraint.activate([
            shoppingCart.widthAnchor.constraint(equalToConstant: 37),
            shoppingCart.heightAnchor.constraint(equalToConstant: 37)
        ])
        
        NSLayoutConstraint.activate([
            segmentControl.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            segmentControl.topAnchor.constraint(equalTo: starStack.bottomAnchor, constant: 25),
            segmentControl.heightAnchor.constraint(equalToConstant: 35),
            segmentControl.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            featuresStack.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 25),
            featuresStack.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor,constant: 25),
            featuresStack.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -25),
            featuresStack.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            selectColorLabel.topAnchor.constraint(equalTo: featuresStack.bottomAnchor, constant: 25),
            selectColorLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            addToCart.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor),
            addToCart.trailingAnchor.constraint(equalTo: segmentControl.trailingAnchor),
            addToCart.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -25),
            addToCart.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    @objc func buttoAction(sender: UIButton) {
        switch sender {
        case backButton:
            onAction?(.back)
        case addToCart:
            onAction?(.addCart)
        case shoppingCart:
            onAction?(.cart)
        default:
            break
        }
    }
}
extension DetailsView: ConfigurableView {
    typealias Model = ModelDetailsView
    
    func configure(with model: ModelDetailsView) {
        self.titleDetails.text = model.title
        self.nameProduct.text = model.nameProduct
        self.cameraLabel.text = model.camera
        self.cpuILabel.text = model.cpu
        self.ssdLabel.text = model.ssd
        self.sdLabel.text = model.sd
        self.selectColorLabel.text = model.selectColor
        self.setupColors(colors: model.color)
        self.setupCapacity(title: model.capacity)
        self.onAction = model.onAction
    }
}
