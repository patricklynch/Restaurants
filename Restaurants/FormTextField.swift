//
//  FormTextField.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/8/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

/// Simple subclass that adds a margin around the content of the textfield
/// and sets other customized appearance properties.
class FormTextField: UITextField {
    
    let inset: CGFloat = 10
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = Color.darkGray.cgColor
    }
}
