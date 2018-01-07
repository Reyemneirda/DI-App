//
//  CustomSegmentedControl.swift
//  
//
//  Created by Gabriel Drai on 28/12/2017.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIView {
    var buttons = [UIButton]()
    
    
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
    var textColor: UIColor = .red
    
    
    
    
    func updateView() {
        
        buttons.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
            
        }
        
        let buttonTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            buttons.append(button)
        }
        
        let sv = UIStackView (arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        
        
        
    }
    
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
    }
    
    

}
