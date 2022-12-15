//
//  AddCount.swift
//  Ecommerce Concept
//
//  Created by APPLE on 06.12.2022.
//

import UIKit

enum StateButton {
    case add
    case subtract
}

protocol CustomAddCountDelegate: AnyObject {
    func featchCount(count: Int, sender: UIButton)
}

final class CustomAddCount: UIView {
    
    weak var delegate: CustomAddCountDelegate?
    
    private lazy var plusButton = UIButton()
        .setMyStyle(backgroundColor: .clear)
        .setTitle(
            font: UIFont.boldSystemFont(ofSize: 21),
            title: "+",
            color: .white)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private lazy var minusButton = UIButton()
        .setMyStyle(backgroundColor: .clear)
        .setTitle(
            font: UIFont.boldSystemFont(ofSize: 30),
            title: "-",
            color: .white)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    public let countLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.cartProductTitle!)
        .setTextColor(color: .white)
    
    private let containerStack = UIStackView()
        .myStyleStack(
            spacing: 5,
            alignment: .fill ,
            axis: .vertical,
            distribution: .fillEqually,
            userInteraction: true)
        .setLayoutMargins(top: 5, left: 0, bottom: 8, right: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.addcount
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setViewHierarhies() {
        self.addSubview(containerStack)
        
        containerStack.addArrangedSubview(minusButton)
        containerStack.addArrangedSubview(countLabel)
        containerStack.addArrangedSubview(plusButton)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: self.topAnchor),
            containerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc func buttonAction(sender: UIButton) {
        guard let count = Int(countLabel.text!) else { return }
        
        var currentCount = count
        
        var action: StateButton = .add
        
        switch sender.titleLabel?.text {
        case "-":
            action = .subtract
        case "+":
            action = .add
        default:
            break
        }
        
        switch count {
        case _ where count > 0:
            switch action {
            case .add:
                currentCount += 1
                countLabel.text = String(currentCount)
                
            case .subtract:
                currentCount -= 1
                countLabel.text = String(currentCount)
            }
        case _ where count == 0:
            switch action {
            case .add:
                currentCount += 1
                countLabel.text = String(currentCount)
            case .subtract:
                break
            }
        default:
            break
        }
        
        delegate?.featchCount(count: currentCount, sender: sender)
    }
}

