//
//  IBTextfield.swift
//  Snappic
//
//  Created by Vision Mkhabela on 4/21/18.
//  Copyright © 2018 Shivono. All rights reserved.
//

import Foundation
import  UIKit

@IBDesignable
class IBTextfield: UITextField, UITextFieldDelegate {
 
   var isValidTextField: Bool = false
   var isTextFieldActive: Bool = true
   
   // MARK: TextField Inspectables

   @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
   @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
   @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = self.borderColor?.cgColor
        }
    }
    
    // MARK: TextField Constructors

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: TextField Delegate Methods

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.isTextFieldActive = false
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let resultString = (textField.text! as NSString).replacingCharacters(in:range, with: string)
        return textValidation(withResultString: resultString)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
         self.isTextFieldActive = true
    }
    
    func textValidation(withResultString: String) -> Bool {

        let textWithNoSpaces = withResultString.replacingOccurrences(of: " ", with: "")
        guard let validHour = Int(textWithNoSpaces) else { return  true }
        
        if  validHour <= 23 {
            self.isValidTextField = true
            return true
        } else {
            self.isValidTextField = false
        }
        return false
    }
}

