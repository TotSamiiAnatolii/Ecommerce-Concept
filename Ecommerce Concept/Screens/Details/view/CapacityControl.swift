//
//  CustomControl.swift
//  Ecommerce Concept
//
//  Created by APPLE on 10.12.2022.
//

import UIKit

class CapacityControl: UIView {
    
    private var titlesForButtons:[String] = []
    
    private var buttons: [UIButton] = []
        
    private var textColor:UIColor = Colors.segmentControl
        
    private var selectorTextColor: UIColor = .white
    
    private var selectorTextFont: UIFont = Fonts.memoryButton!
    
    weak var delegate: DetailsSegmentedControlDelegate?
    
    private var selectedIndex : Int = 0
    
    convenience init(frame:CGRect, buttonTitle:[String]) {
        self.init(frame: frame)
        self.titlesForButtons = buttonTitle
        createButton()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        updateView()
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in titlesForButtons {
            let button = UIButton()
            button.backgroundColor = Colors.mainBackGround
            button.setTitle("\(buttonTitle) gb", for: .normal)
            button.addTarget(self, action:#selector(DetailsSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = Fonts.memoryButton!
            button.layer.cornerRadius = 10
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].titleLabel?.font = Fonts.memoryButton!
        buttons[0].backgroundColor = Colors.orange
    }
    
    @objc func buttonAction(sender: UIButton) {
    
        for (buttonIndex, button) in buttons.enumerated() {
            
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = Fonts.memoryButton!
            button.backgroundColor = Colors.mainBackGround
            if button == sender {
                
                selectedIndex = buttonIndex
                delegate?.onAction(index: selectedIndex)
               
                button.setTitleColor(selectorTextColor, for: .normal)
                
                button.titleLabel?.font = Fonts.memoryButton!
                
                button.backgroundColor = Colors.orange
            }
        }
    }
}
extension CapacityControl {
    private func updateView() {
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 5
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
}
