//
//  ColorControl.swift
//  Ecommerce Concept
//
//  Created by APPLE on 10.12.2022.
//

import UIKit

class ColorControl: UIView {
    
    private var nameColorsForButtons: [String] = []
    
    private var buttons: [UIButton] = []
            
    private let chek: UIImage = Images.checkmark!
    
    private var selectorTextColor: UIColor = .white
    
    private var selectorTextFont: UIFont = Fonts.memoryButton!
    
    weak var delegate: DetailsSegmentedControlDelegate?
    
    private var selectedIndex : Int = 0
    
    convenience init(frame:CGRect, buttonTitle:[String]) {
        self.init(frame: frame)
        self.nameColorsForButtons = buttonTitle
        createButton()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        updateView()
        
        buttons.forEach { button in
            button.layer.cornerRadius = 19.5
            
        }
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in nameColorsForButtons {
            let button = UIButton()
            button.backgroundColor = hexStringToUIColor(hex: buttonTitle)
            button.addTarget(self, action:#selector(DetailsSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.titleLabel?.font = Fonts.memoryButton!
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 39),
                button.heightAnchor.constraint(equalToConstant: 39)
           
            ])
            buttons.append(button)
        }
        buttons[0].setImage(chek.withTintColor(.white), for: .normal)
    }
    
    @objc func buttonAction(sender: UIButton) {
    
        for (buttonIndex, button) in buttons.enumerated() {
            
            button.setImage(nil, for: .normal)
            
            if button == sender {
                
                selectedIndex = buttonIndex
                delegate?.onAction(index: selectedIndex)
               
                button.setImage(chek.withTintColor(.white), for: .normal)
                
                
            }
        }
    }
}
extension ColorControl {
    private func updateView() {
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 15
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
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
