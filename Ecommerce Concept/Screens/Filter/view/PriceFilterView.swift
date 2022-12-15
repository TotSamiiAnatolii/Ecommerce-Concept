//
//  PriceFilterView.swift
//  Ecommerce Concept
//
//  Created by APPLE on 11.12.2022.
//

import UIKit

final class PriceFilterView: UIView {
    
    private var onActionNavBar: ((NavBarItem) -> Void)?
    
    public var sliderAction: ((_ from: CGFloat, _ to: CGFloat) -> Void)?
    
    private let rangeSlider = RangeSlider(frame: .zero)
    
    private let topIndent: CGFloat = 24
    
    private let leftIndentNavBar: CGFloat = 44
    
    private let leftIndent: CGFloat = 20
    
    private let rightIndent: CGFloat = 20
    
    private let heightPriceStack: CGFloat = 40
    
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
    
    private let from = UITextView()
        .setMyStyle(textAligment: .left, font: Fonts.productDetails!)
    
    private let to = UITextView()
        .setMyStyle(textAligment: .left, font: Fonts.productDetails!)
    
    private let textViewStack = UIStackView()
        .myStyleStack(
            spacing: 5,
            alignment: .fill ,
            axis: .horizontal,
            distribution: .fillProportionally,
            userInteraction: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        rangeSlider.addTarget(self, action: #selector(valueSlider),
                              for: .valueChanged)
        valueSlider(slider: rangeSlider)
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(navBarStack)
        self.addSubview(rangeSlider)
        self.addSubview(textViewStack)
        
        navBarStack.addArrangedSubview(closeButton)
        navBarStack.addArrangedSubview(title)
        navBarStack.addArrangedSubview(doneButton)
        
        textViewStack.addArrangedSubview(from)
        textViewStack.addArrangedSubview(to)
        
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            navBarStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftIndentNavBar),
            navBarStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -rightIndent),
            navBarStack.topAnchor.constraint(equalTo: self.topAnchor, constant: topIndent)
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
            textViewStack.heightAnchor.constraint(equalToConstant: heightPriceStack),
            textViewStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftIndent),
            textViewStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -rightIndent),
            textViewStack.topAnchor.constraint(equalTo: navBarStack.bottomAnchor, constant: topIndent * 2)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = 20
        let width = self.bounds.width - 2 * margin
        let height: CGFloat = 5
        
        rangeSlider.frame = CGRect(
            x: 0,
            y: textViewStack.frame.maxY + 2 * margin,
            width: width,
            height: height)
        rangeSlider.center.x = self.center.x
    }
    
    @objc func valueSlider(slider: RangeSlider) {
        let fromNumber = 2000 * slider.lowerValue
        
        let toNumber = 2000 * slider.upperValue
        
        from.text =  NumberFormatter.formatToCurrency(maximumFractionDigits: 0).string(from: fromNumber as NSNumber)
        
        to.text = NumberFormatter.formatToCurrency(maximumFractionDigits: 0).string(from: toNumber as NSNumber)
        sliderAction?(fromNumber, toNumber)
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
extension PriceFilterView: ConfigurableView {
    func configure(with model: ModelPriceView) {
        self.onActionNavBar = model.onAction
        self.title.text = model.title
    }
    
    typealias Model = ModelPriceView
}
