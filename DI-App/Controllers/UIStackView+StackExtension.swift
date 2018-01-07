//
//  StackExtension.swift
//  DI-App
//
//  Created by Adrien Meyer on 24/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView
{
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
}
