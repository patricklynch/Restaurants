//
//  NavigationController.swift
//  Restaurants
//
//  Created by Patrick Lynch on 2/8/17.
//  Copyright © 2017 lynchdev. All rights reserved.
//

import UIKit

/// Provides custom behavior and appearance to be shared
/// among navigation controllers in this application.
class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = Color.orange
        navigationBar.titleTextAttributes = [
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14.0),
            NSForegroundColorAttributeName : UIColor.white
        ]
        
        toolbar.barTintColor = Color.orange
        toolbar.tintColor = UIColor.white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
