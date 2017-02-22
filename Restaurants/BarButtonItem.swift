//
//  BarButtonItem.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/22/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

class BarButtonItem: UIBarButtonItem {
    
    convenience init(title: String?, target: Any?, action: Selector?) {
        let button = UIButton(type: .custom)
        button.backgroundColor = Color.darkOrange
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10.0)
        button.setTitle(title?.uppercased(), for: .normal)
        button.sizeToFit()
        button.bounds = CGRect(
            x: button.bounds.origin.x,
            y: button.bounds.origin.x,
            width: button.bounds.width + 20.0,
            height: button.bounds.height
        )
        let textColor = UIColor.white.withAlphaComponent(0.75)
        button.setTitleColor(textColor, for: .normal)
        if let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        self.init(customView: button)
    }
}
