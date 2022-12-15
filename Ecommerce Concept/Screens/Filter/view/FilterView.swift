//
//  FilterView.swift
//  Ecommerce Concept
//
//  Created by APPLE on 08.12.2022.
//

import UIKit

enum PositionFilter: String, CaseIterable {
    case brand = "Brand"
    case price = "Price"
    case size = "Size"
}

enum NavBarItem {
    case close
    case done
}

final class FilterView: UIView {
    
    private var onAction: ((PositionFilter) -> Void)?
    
    private var onActionNavBar: ((NavBarItem) -> Void)?
    
    private var buttons: [UIStackView] = []
    
    private var arrayPlaceholder: [String] = []
    
    private let topIndentNavBar: CGFloat = 24
    
    private let topIndent: CGFloat = 40
    
    private let leftIndentNavBar: CGFloat = 44
    
    private let leftIndent: CGFloat = 0
    
    private let rightIndent: CGFloat = 20
    
    private let rightIndentFilterParam: CGFloat = 30
    
    private let heightNavBar: CGFloat = 40
    
    private func createFilterStack() {
        for (index, type) in PositionFilter.allCases.enumerated() {
            let label = UILabel()
                .setMyStyle(
                    numberOfLines: 1,
                    textAlignment: .left,
                    font: Fonts.productDetails!)
                .setTextColor(color: Colors.darkBlue)
            label.text = type.rawValue
            
            let button = createButton()
            button.tag = index
            let stackView = createStackView()
            
            stackView.addArrangedSubview(label)
            stackView.addArrangedSubview(button)
            
            buttons.append(stackView)
        }
    }
    
    private func createButton() -> UIButton {
        
        let heightButton: CGFloat = 37
        
        let button = MyButtonFromAndTo(frame: CGRect(
            x: 0,
            y: 0,
            width: self.frame.width,
            height: heightButton))
            .setTarget(
                method: #selector(buttonAction),
                target: self,
                event: .touchUpInside)
        return button
    }
    
    private func createStackView() -> UIStackView {
        let textStack = UIStackView()
            .myStyleStack(
                spacing: 10,
                alignment: .fill ,
                axis: .vertical,
                distribution: .equalSpacing,
                userInteraction: true)
        
        return textStack
    }
    
    private func filterParamAddSubViews() {
        buttons.forEach { stack in
            filterParamStack.addArrangedSubview(stack)
        }
    }
    
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
            method: #selector(navBarAction),
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
            method: #selector(navBarAction),
            target: self,
            event: .touchUpInside)
    
    private let navBarStack = UIStackView()
        .myStyleStack(
            spacing: 0,
            alignment: .fill ,
            axis: .horizontal,
            distribution: .fillProportionally,
            userInteraction: true)
    
    private let filterParamStack = UIStackView()
        .myStyleStack(
            spacing: 10,
            alignment: .fill ,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        createFilterStack()
        filterParamAddSubViews()
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func setViewHierarhies() {
        self.addSubview(navBarStack)
        self.addSubview(filterParamStack)
        
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
            filterParamStack.topAnchor.constraint(equalTo: navBarStack.bottomAnchor, constant: topIndent),
            filterParamStack.leadingAnchor.constraint(equalTo: navBarStack.leadingAnchor),
            filterParamStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -rightIndentFilterParam)
        ])
    }
    
    @objc func buttonAction(sender: UIButton) {
        switch sender.tag {
        case 0:
            onAction?(.brand)
        case 1:
            onAction?(.price)
        case 2:
            onAction?(.size)
        default:
            break
        }
    }
    
    @objc func navBarAction(sender: UIButton) {
        switch sender {
        case closeButton:
            onActionNavBar?(.close)
        case doneButton:
            onActionNavBar?(.done)
        default:
            break
        }
    }
    
    private func createPlaceholder(model: ModelFilterView) {
        print(model.brandPlaceholder)
        arrayPlaceholder.removeAll()
        arrayPlaceholder.append(model.brandPlaceholder)
        arrayPlaceholder.append(model.pricePlaceholder)
        arrayPlaceholder.append(model.sizePlaceholder)
    }
}
extension FilterView: ConfigurableView {
    
    typealias Model = ModelFilterView
    
    func configure(with model: ModelFilterView) {
        self.title.text = model.title
        self.onAction = model.onAction
        self.onActionNavBar = model.onACtionNavBar
        
        createPlaceholder(model: model)
  
        for (index, stack) in buttons.enumerated() {
            stack.subviews.forEach { view in
                guard let button = view as? MyButtonFromAndTo else { return }
                button.configure(model:ModelMyButtonFromAndTo(title: arrayPlaceholder[index]))
            }
        }
    }
}
