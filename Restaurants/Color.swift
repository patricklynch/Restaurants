//
//  Color.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/8/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// Convenience wrapper that creates a color from R, G, B and A components
    /// as integeters representing numerators with a denominator of 255
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// Returns a UIColor constructed from the hex code
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}

/// Global colors customized for this application
class Color {
    static var orange = UIColor(hex: 0xff8800)
    static var darkOrange = UIColor(hex: 0xe17800)
    static var darkGray = UIColor(hex: 0x353535)
    static var mediumGray = UIColor(hex: 0xd2d2d2)
    static var lightGray = UIColor(hex: 0xeeeeee)
}
