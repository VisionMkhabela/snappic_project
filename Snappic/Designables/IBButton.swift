//
//  IBButton.swift
//  Snappic
//
//  Created by Vision Mkhabela on 4/21/18.
//  Copyright © 2018 Shivono. All rights reserved.
//


import Foundation
import UIKit

@IBDesignable
class IBButton: UIButton {
    
    // MARK: Button Inspectables 

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.shadowColor = shadowColor?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.shadowColor = borderColor?.cgColor
        }
    }
    
}
