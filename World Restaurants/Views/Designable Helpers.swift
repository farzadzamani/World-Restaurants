//
//  RestaurantListCartView.swift
//  World Restaurants
//
//  Created by Farzad on 2/14/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class TableRowCartView: UIView {
    @IBInspectable var cornerRadius : CGFloat = 0
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    
    @IBInspectable var shadowOffSetWith : Int = 0
    @IBInspectable var shadowOffHeight : Int = 1
    
    @IBInspectable var shadowCapacity : Float = 0.2
    
    override func layoutSubviews() {
//        layer.cornerRadius = cornerRadius
//        layer.shadowColor = shadowColor?.cgColor
//        layer.shadowOffset = CGSize(width: shadowOffSetWith, height: shadowOffHeight)
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//        layer.shadowPath = shadowPath.cgPath
//        layer.shadowOpacity = shadowCapacity
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWith, height: shadowOffHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowCapacity
        
    }
}


