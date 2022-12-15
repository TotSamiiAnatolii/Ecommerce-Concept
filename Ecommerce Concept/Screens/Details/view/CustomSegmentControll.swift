//
//  CustomSegmentControll.swift
//  Ecommerce Concept
//
//  Created by APPLE on 06.12.2022.
//

import UIKit

protocol DetailsSegmentedControlDelegate: AnyObject {
    func onAction(index: Int)
}

class DetailsSegmentedControl: UIView {
    
    private var titlesForButtons:[String] = []
    
    private var buttons:[UIButton] = []
    
    private var selectorView: UIView!
    
    private var textColor:UIColor = Colors.segmentControl
    
    private var selectorViewColor: UIColor = Colors.orange
    
    private var selectorTextColor: UIColor = Colors.darkBlue
    
    private var selectorTextFont: UIFont = Fonts.segmentControl!
    
    weak var delegate: DetailsSegmentedControlDelegate?
    
    private var selectedIndex : Int = 0
    
    convenience init(frame:CGRect, buttonTitle:[String]) {
        self.init(frame: frame)
        self.titlesForButtons = buttonTitle
        createButton()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in titlesForButtons {
            let button = UIButton(type: .system)
            button.backgroundColor = Colors.mainBackGround
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = Fonts.segmentControlNo!
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].titleLabel?.font = Fonts.segmentControl!
    }
    
    @objc func buttonAction(sender: UIButton) {
    
        for (buttonIndex, button) in buttons.enumerated() {
            
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = Fonts.segmentControlNo!
            if button == sender {
                
                let width = frame.width / CGFloat(self.titlesForButtons.count)
                selectedIndex = buttonIndex
                delegate?.onAction(index: selectedIndex)
                UIView.animate(withDuration: 0.3) {
                    
                    self.selectorView.frame.size = CGSize(width: width, height: 3)
                    self.selectorView.center.x = button.center.x
                }
                button.setTitleColor(selectorTextColor, for: .normal)
                button.titleLabel?.font = Fonts.segmentControl!
            }
        }
    }
}
extension DetailsSegmentedControl {
    private func updateView() {
        configStackView()
        configSelectorView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 20
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = Colors.mainBackGround
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leftAnchor.constraint(equalTo: self.leftAnchor),
            stack.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    func updateSelectorView(centerX: CGFloat) {
        self.selectorView.center.x = centerX
    }
    
    public func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.titlesForButtons.count) * 0.8
        
        selectorView = UIView(frame: CGRect(x: -17, y: self.frame.height, width: selectorWidth, height: 3))
        selectorView.backgroundColor = selectorViewColor
        selectorView.layer.cornerRadius = 1.5
        addSubview(selectorView)
    }
}
