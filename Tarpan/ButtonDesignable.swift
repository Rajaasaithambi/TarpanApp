//
//  ButtonDesignable.swift
//  Tarpan
//
//  Created by raja A on 5/30/17.
//  Copyright © 2017 raja A. All rights reserved.
//

import UIKit

@IBDesignable class ButtonDesignable: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}


@IBDesignable class viewDesignable: UIView {
    
    @IBInspectable var carnerRadius: CGFloat = 0.0 {
        
        didSet {
            layer.cornerRadius = carnerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}

@IBDesignable class imageDesignable: UIImageView {

    @IBInspectable var carnerRadius: CGFloat = 0.0 {

        didSet {
            layer.cornerRadius = carnerRadius
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {

        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}

