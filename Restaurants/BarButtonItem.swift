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
        button.bounds = CGRect(x: 0, y: 0, width: 30.0, height: 25.0)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 5.0
        button.setTitle(title?.uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10.0)
        let textColor = UIColor.white.withAlphaComponent(0.75)
        button.setTitleColor(textColor, for: .normal)
        if let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        self.init(customView: button)
    }
}
