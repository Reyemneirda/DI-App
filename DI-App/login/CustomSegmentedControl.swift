//
//  CustomSegmentedControl.swift
//  
//
//  Created by Gabriel Drai on 28/12/2017.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIView {
    
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

   
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
    }
    

}
