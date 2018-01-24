//
//  CustomSegmentedControl.swift
//  
//
//  Created by Gabriel Drai on 28/12/2017.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIControl {
    
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    var titleForSegment = "Login"

    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable
    var commaSeperatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
   
    @IBInspectable
    var textColor: UIColor = .red {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .red {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        buttons.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
            
        }
        
        let buttonTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitleColor(textColor, for: .normal)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button: )), for: .touchUpInside)
            
            buttons.append(button)
        }
        
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height/2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let sv = UIStackView (arrangedSubviews: buttons)
        
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    
    }
    
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
        updateView()
    }
    
    @objc func buttonTapped(button: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
        
        if btn == button {
            self.selectedSegmentIndex = buttonIndex
            self.titleForSegment = (btn.titleLabel?.text)!
            let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
            UIView.animate(withDuration: 0.3, animations: {
                self.selector.frame.origin.x = selectorStartPosition
            })
          
            btn.setTitleColor(selectorTextColor, for: .normal)
        }
        }
        
        sendActions(for: .valueChanged)
    }
    

}
